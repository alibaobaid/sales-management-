json.extract! delegate, :id, :name, :city, :phone_NO, :amount_of_box, :amount_of_gallon, :for_him, :to_him, :created_at, :updated_at
json.url delegate_url(delegate, format: :json)
