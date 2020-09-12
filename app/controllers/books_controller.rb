class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    authors = params[:authors].split(",")
    authors_exists, author_id = Author.authors_exists? authors
    if !authors_exists
      render json: { status: "ERROR", message: "Couldn't find Author with id #{author_id}" }, status: :unprocessable_entity
    elsif @book.save
      authors.each do |author|
        @book.book_authors.create(author_id: author)
      end
      render json: { status: "SUCCESS", message: "Book is added", data: [book: @book, authors: @book.authors], status: :ok }
    else
      render json: { status: "ERROR", message: "Book is not added", errors: @book.errors.messages }, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :edition, :publication_year)
  end
end
