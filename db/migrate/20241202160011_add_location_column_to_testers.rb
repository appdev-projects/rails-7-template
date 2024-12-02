class AddLocationColumnToTesters < ActiveRecord::Migration[7.1]
  def change
    add_column :testers, :location, :string, default: "Backstage", null: false
  end
end
