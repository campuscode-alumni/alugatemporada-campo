class RemoveMainPhotoFromProperties < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :main_photo, :string
  end
end
