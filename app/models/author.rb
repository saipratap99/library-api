class Author < ApplicationRecord
  has_many :book_authors
  has_many :books, through: :book_authors
  validates :name, presence: true, uniqueness: true

  def self.authors_exists?(authors)
    authors.each do |author|
      unless (Author.where(id: author).exists?)
        #render json: { status: "ERROR", message: "Couldn't find Author with id #{author}" }, status: :unprocessable_entity
        return false, author
      end
    end
    return true, nil
  end
end
