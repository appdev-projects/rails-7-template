class AddDetailsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :details, :text
  end
end
