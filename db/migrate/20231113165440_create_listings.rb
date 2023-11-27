class CreateListings < ActiveRecord::Migration[7.0]
  def change
    create_table :listings do |t|
      t.integer :retailer_id
      t.integer :product_id
      t.string :url

      t.timestamps
    end
  end
end
