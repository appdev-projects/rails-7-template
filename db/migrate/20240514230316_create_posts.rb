class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :subject
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
