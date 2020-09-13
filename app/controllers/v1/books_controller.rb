module V1
  class BooksController < ApplicationController
    def index
      @books = Book.page(page).per(per_page)
      render json: { books: @books, meta: { pagination: { per_page: per_page, total_pages: page_count, books: Book.count, current_page: page } } }
    end

    def show
      @book = Book.find(params[:id])
      render json: { status: "SUCCESS", message: "Book is fetched", data: [book: @book, authors: @book.authors] }
    end

    def create
      @book = Book.new(book_params)
      authors = params[:authors]

      if authors.nil? || authors.empty?
        authors_not_found, msg = true, "For book atleast one Author must exists"
      else
        authors = authors.split(",")
        authors_not_found, msg = Author.authors_exists? authors
      end

      if authors_not_found
        render json: { status: "ERROR", message: msg }
      elsif @book.save
        @book.add_authors_to_book authors
        render json: { status: "SUCCESS", message: "Book is added", data: [book: @book, authors: @book.authors] }
      else
        render json: { status: "ERROR", message: "Book is not added", errors: [book: @book.errors.messages] }
      end
    end

    def update
      @book = Book.find(params[:id])
      authors = params[:authors]

      if !(authors.nil? || authors.empty?)
        authors = authors.split(",")
        authors_not_found, msg = Author.authors_exists? authors
      end

      if authors_not_found
        render json: { status: "ERROR", message: msg }
      elsif @book.update_attributes (book_params)
        @book.add_authors_to_book authors if !(authors.nil? || authors.empty?)
        render json: { status: "SUCCESS", message: "Book is updated", data: [book: @book, authors: @book.authors] }
      else
        render json: { status: "ERROR", message: "Book is not updated", errors: [book: @book.errors.messages] }
      end
    end

    def destroy
      @book = Book.find(params[:id])
      authors = @book.authors
      if @book.destroy
        render json: { status: "SUCCESS", message: "Book is deleted", data: [book: @book, authors: authors] }
      else
        render json: { status: "ERROR", message: "Book is not deleted", errors: [book: @book.errors.messages] }
      end
    end

    private

    def book_params
      params.require(:book).permit(:name, :edition, :publication_year, :authors)
    end

    def page
      @page ||= params[:page] || 1
    end

    def per_page
      @per_page ||= params[:per_page] || 10
    end

    def page_count
      count = Book.count / per_page.to_f
      count.ceil
    end
  end
end
