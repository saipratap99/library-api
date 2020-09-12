class BooksController < ApplicationController
  def create
    @book = Book.new(book_params)
    if @book.save
      render json: { status: "SUCCESS", message: "Book is added", data: @book }, status: :ok
    else
      render json: { status: "ERROR", message: "Book is not added", data: @book.erros }, status: :unprocessable_entity
    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :edition, :publication_year)
  end
end
