class CreateShops < ActiveRecord::Migration[7.1]
  def change
    create_table :shops do |t|
      t.integer :shop_number
      t.string :address
      t.boolean :at_kohls

      t.timestamps
    end
  end
end
