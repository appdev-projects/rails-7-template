json.extract! review, :id, :rating, :body, :sender_id, :recipient_id, :created_at, :updated_at
json.url review_url(review, format: :json)
