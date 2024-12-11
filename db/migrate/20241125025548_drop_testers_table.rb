# This is throwing an errpr because the table is already dropped
class DropTestersTable < ActiveRecord::Migration[7.1]
#   def up
#     drop_table :testers do |t|
#       t.string :condition
#       t.datetime :trashed_at
#       t.bigint :product_id, null: false
#       t.bigint :shop_id, null: false
#       t.timestamps
#     end
#   end

#   def down
#     create_table :testers do |t|
#       t.string :condition
#       t.datetime :trashed_at
#       t.references :product, null: false, foreign_key: true
#       t.references :shop, null: false, foreign_key: true
#       t.timestamps
#     end
#   end
end
