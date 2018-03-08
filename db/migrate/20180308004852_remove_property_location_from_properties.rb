class RemovePropertyLocationFromProperties < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :property_location, :string
  end
end
