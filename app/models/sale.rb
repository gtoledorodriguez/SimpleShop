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
end
