class RemoveAvatarFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :avatar, :string
  end
end
