# == Schema Information
#
# Table name: sales
#
#  id             :bigint           not null, primary key
#  quanitity_sold :integer
#  total_price    :float
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  item_id        :integer
#  user_id        :integer
#
class Sale < ApplicationRecord
  belongs_to :item, required: true, class_name: "Item", foreign_key: "item_id", counter_cache: true
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id", counter_cache: true

  has_one :business, through: :item
end
