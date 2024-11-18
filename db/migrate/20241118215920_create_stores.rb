class CreateStores < ActiveRecord::Migration[7.1]
  def change
    create_table :stores do |t|
      t.integer :store_number
      t.string :address
      t.boolean :at_kohls

      t.timestamps
    end
  end
end
