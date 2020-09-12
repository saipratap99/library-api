class Book < ApplicationRecord
  has_many :book_authors
  has_many :authors, through: :book_authors
  validates :name, presence: true, uniqueness: true
  validates :edition, :publication_year, presence: true
  validates_associated :authors
end
