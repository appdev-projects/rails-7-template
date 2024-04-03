class AddColumnsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_column :users, :admin, :boolean
    add_column :users, :facilitator, :boolean
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end
