class ChangeDataTypeForBody < ActiveRecord::Migration[7.1]
  def change
    change_column :reviews, :body, :text
  end
end
