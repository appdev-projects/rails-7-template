class CreateRetailers < ActiveRecord::Migration[7.0]
  def change
    create_table :retailers do |t|
      t.string :name
      t.integer :listing_count, default: 0

      t.timestamps
    end
  end
end
