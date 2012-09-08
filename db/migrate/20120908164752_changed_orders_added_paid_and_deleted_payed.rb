 class ChangedOrdersAddedPaidAndDeletedPayed < ActiveRecord::Migration
  def self.up
    add_column :orders, :paid, :boolean, :null => false, :default => false
    remove_column :orders, :payed
  end
  
  def self.down
    add_column :orders, :payed, :boolean, :null => false, :default => :false
    remove_column :orders, :paid
  end
end
