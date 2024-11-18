class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :name
      t.references :brand, null: false, foreign_key: true
      t.string :image
      t.references :department, null: false, foreign_key: true
      t.integer :sku

      t.timestamps
    end
  end
end
