class CreatePriceRanges < ActiveRecord::Migration[5.1]
  def change
    create_table :price_ranges do |t|
      t.string :description
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :daily_rate

      t.timestamps
    end
  end
end
