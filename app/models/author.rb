class Author < ApplicationRecord
  has_many :book_authors, dependent: :destroy
  has_many :books, through: :book_authors
  validates :name, presence: true, uniqueness: true

  def self.authors_exists?(authors)
    ids_not_exists = []
    authors.each do |author|
      unless (Author.where(id: author).exists?)
        ids_not_exists << author
      end
    end
    msg = "Couldn't find Author with #{"id".pluralize(ids)}. #{ids_not_exists.join(",")}"
    return ids_not_exists.empty? ? [false, nil] : [true, msg]
  end
end
