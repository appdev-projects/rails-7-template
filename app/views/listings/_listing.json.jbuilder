json.extract! listing, :id, :retailer_id, :product_id, :url, :created_at, :updated_at
json.url listing_url(listing, format: :json)
