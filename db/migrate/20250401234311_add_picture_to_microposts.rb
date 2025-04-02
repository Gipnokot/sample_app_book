class AddPictureToMicroposts < ActiveRecord::Migration[7.2]
  def change
    add_column :microposts, :picture, :string
  end
end
