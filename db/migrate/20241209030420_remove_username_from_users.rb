class RemoveUsernameFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :username, :citext
  end
end
