class CreateGenres < ActiveRecord::Migration[7.1]
  def change
    create_table :genres do |t|
      t.references :movie, null: false, foreign_key: true
      t.string :genre_type
      t.timestamps
    end
  end
end
