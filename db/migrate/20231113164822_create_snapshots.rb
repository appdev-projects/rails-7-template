class CreateSnapshots < ActiveRecord::Migration[7.0]
  def change
    create_table :snapshots do |t|
      t.integer :price
      t.integer :listing_id

      t.timestamps
    end
  end
end
