json.extract! bank, :id, :name, :balance, :desc, :country, :created_at, :updated_at
json.url bank_url(bank, format: :json)
