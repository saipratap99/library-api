class BooksController < ApplicationController
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

  private

  def book_params
    params.require(:book).permit(:name, :edition, :publication_year)
  end
end
