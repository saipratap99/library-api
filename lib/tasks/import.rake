require "csv"

namespace :import do
  desc "Imports the authors data"

  task authors: :environment do
    file = Rails.root.join("lib/assets/authors.csv")
    CSV.foreach(file, :headers => true) do |row|
      Author.create(row.to_hash)
    end
  end
end
