class CreateReleases < ActiveRecord::Migration[5.2]
  def change
    create_table :releases do |t|
      t.string :year
      t.string :title
      t.string :format, array: true
      t.string :genre
      t.string :tracklist, array: true
      t.references :artist, foreign_key: true
      t.references :label, foreign_key: true

      t.timestamps
    end
  end
end
