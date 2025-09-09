# == Schema Information
#
# Table name: items
#
#  id                  :bigint           not null, primary key
#  low_stock_threshold :integer
#  name                :string
#  price               :float
#  quantity_in_stock   :integer
#  sales_count         :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  business_id         :integer
#
class Item < ApplicationRecord
end
