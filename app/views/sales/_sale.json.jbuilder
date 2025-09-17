json.extract! sale, :id, :item_id, :user_id, :quantity_sold, :total_price, :created_at, :updated_at
json.url sale_url(sale, format: :json)
