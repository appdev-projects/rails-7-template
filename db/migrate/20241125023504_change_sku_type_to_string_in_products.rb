class ChangeSkuTypeToStringInProducts < ActiveRecord::Migration[7.1]
  def change
    change_column :products, :sku, :string
  end
end
