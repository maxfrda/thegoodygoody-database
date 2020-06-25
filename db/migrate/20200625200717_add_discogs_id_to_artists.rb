class AddDiscogsIdToArtists < ActiveRecord::Migration[5.2]
  def change
    add_column :artists, :discogs_id, :integer
  end
end
