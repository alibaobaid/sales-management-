json.extract! sales_operation, :id, :date, :delegate_id, :commodity_type, :commodity_amount, :price, :marketer_id, :delegate_commission, :marketer_commission, :created_at, :updated_at
json.url sales_operation_url(sales_operation, format: :json)
