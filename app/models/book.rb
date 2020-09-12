class Book < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :authors, through: :book_authors
  validates :name, presence: true, uniqueness: true
  validates :edition, :publication_year, presence: true

  def add_authors_to_book(authors)
    authors.each do |author|
      self.book_authors.create(author_id: author)
    end
  end
end
