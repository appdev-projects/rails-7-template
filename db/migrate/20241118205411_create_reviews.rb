class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.float :rating, default: 0.0
      t.time :body
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end
  end
end
