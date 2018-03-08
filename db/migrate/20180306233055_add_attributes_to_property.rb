class AddAttributesToProperty < ActiveRecord::Migration[5.1]
  def change
    add_column :properties, :description, :text
    add_column :properties, :neighborhood, :string
    add_column :properties, :accessibility, :boolean
    add_column :properties, :allow_pets, :boolean
    add_column :properties, :allow_smokers, :boolean
    add_column :properties, :rooms, :integer
  end
end
