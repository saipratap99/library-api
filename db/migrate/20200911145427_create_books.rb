class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name
      t.integer :edition
      t.string :publication_year

      t.timestamps
    end
  end
end
