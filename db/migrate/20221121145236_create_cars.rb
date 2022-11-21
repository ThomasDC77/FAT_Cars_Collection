class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :brand
      t.integer :year
      t.float :price_per_day
      t.string :color
      t.boolean :convertible, default: false
      t.integer :seat_numbers
      t.text :description
      t.integer :number_street
      t.string :name_street
      t.string :post_code
      t.string :city
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
