json.extract! product, :id, :name, :brand_id, :image, :department_id, :sku, :created_at, :updated_at
json.url product_url(product, format: :json)
