json.extract! item, :id, :business_id, :name, :price, :quantity_in_stock, :low_stock_threshold, :sales_count, :created_at, :updated_at
json.url item_url(item, format: :json)
