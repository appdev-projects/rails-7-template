class RemoveGithubAccessTokenProviderUidFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :github_access_token, :string
    remove_column :users, :provider, :string
    remove_column :users, :uid, :string
  end
end
