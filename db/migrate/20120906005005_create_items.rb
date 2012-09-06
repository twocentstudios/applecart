class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name, :null => false
      t.string :description
      t.decimal :price, :null => false, :default => 0
      t.decimal :cost, :null => false, :default => 0
      t.string :item_photo_uid
    end
  end
  
  def self.down
    drop_table :items
  end
end
