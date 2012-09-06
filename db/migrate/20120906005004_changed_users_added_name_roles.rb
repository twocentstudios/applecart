class ChangedUsersAddedNameRoles < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :roles, :string, :default => "--- []"
  end
  
  def self.down
    remove_column :users, :name
    remove_column :users, :roles
  end
end
