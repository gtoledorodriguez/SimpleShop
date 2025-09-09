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
  belongs_to :business, required: true, class_name: "Business", foreign_key: "business_id", counter_cache: true
  has_many :sales, class_name: "Sale", foreign_key: "item_id", dependent: :nullify

  def status
    if quantity_in_stock <= 0
      "Sold Out"
    elsif quantity_in_stock <= low_stock_threshold
      "Low Stock"
    else
      "In Stock"
    end
  end
end
