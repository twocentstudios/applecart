class CreateOrderItems < ActiveRecord::Migration
  def self.up
    create_table :order_items do |t|
      t.integer :order_id 
      t.integer :item_id 
      t.integer :quantity, :null => false, :default => 0
    end
    add_index :order_items, :order_id
    add_index :order_items, :item_id
  end
  
  def self.down
    drop_table :order_items
  end
end
