class CreateTesters < ActiveRecord::Migration[7.1]
  def change
    create_table :testers do |t|
      t.string :condition
      t.datetime :trashed_at
      t.references :product, null: false, foreign_key: true
      t.references :shop, null: false, foreign_key: true

      t.timestamps
    end
  end
end
