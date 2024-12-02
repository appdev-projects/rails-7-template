class RenameReviewsMessages < ActiveRecord::Migration[7.1]
  def change
    rename_table :reviews, :messages
  end
end
