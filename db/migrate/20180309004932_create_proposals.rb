class CreateProposals < ActiveRecord::Migration[5.1]
  def change
    create_table :proposals do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :rent_purpose
      t.integer :total_guest
      t.date :start_date
      t.date :end_date
      t.boolean :pet
      t.boolean :smoker
      t.decimal :total_amount
      t.text :details
      t.references :property, foreign_key: true

      t.timestamps
    end
  end
end
