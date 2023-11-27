json.extract! product, :id, :name, :description, :image, :listings_count, :created_at, :updated_at
json.url product_url(product, format: :json)
