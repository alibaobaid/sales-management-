json.extract! bank_transfer, :id, :date_of_transfer, :delegates_id, :transfer_type, :section_type, :marketers_id, :mangers_id, :price, :created_at, :updated_at
json.url bank_transfer_url(bank_transfer, format: :json)
