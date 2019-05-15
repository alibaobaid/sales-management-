json.extract! product_discount, :id, :product_type, :reason, :amount, :discount_date, :delegate_id, :created_at, :updated_at
json.url product_discount_url(product_discount, format: :json)
