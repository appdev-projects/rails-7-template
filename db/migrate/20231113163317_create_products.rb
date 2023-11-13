class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :image
      t.integer :product_volume
      t.integer :listings_count, default: 0

      t.timestamps
    end
  end
end
