class AddOriginToCars < ActiveRecord::Migration[7.0]
  def change
    add_column :cars, :origin, :string
  end
end
