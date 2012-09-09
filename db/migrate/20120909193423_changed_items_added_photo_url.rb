class ChangedItemsAddedPhotoUrl < ActiveRecord::Migration
  def self.up
    add_column :items, :photo_url, :string
  end
  
  def self.down
    remove_column :items, :photo_url
  end
end
