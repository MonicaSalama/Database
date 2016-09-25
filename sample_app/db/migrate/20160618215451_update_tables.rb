class UpdateTables < ActiveRecord::Migration
  def self.up
    add_index :users, :firstname
    add_index :users, :lastname
    add_index :users, :hometown
    add_index :microposts, :caption
    change_column_null :users, :firstname, false
    change_column_null :users, :email, false


  end
end
