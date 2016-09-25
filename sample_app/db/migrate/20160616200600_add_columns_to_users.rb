class AddColumnsToUsers < ActiveRecord::Migration
 def up
     
  add_column :users , :maritalstatus ,:string
  add_column :users , :bio ,:text

 change_column_null :users, :lastname, false
 
 change_column_null :users, :gender, false
 
 

 change_column_null :users, :birthdate, false

 

 
 end

 
end