class AddAttributeToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :main_photo, :string
  end
end
