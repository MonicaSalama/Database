class AddPictureToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :postpicture, :string
  end
end
