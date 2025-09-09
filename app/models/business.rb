# == Schema Information
#
# Table name: businesses
#
#  id          :bigint           not null, primary key
#  items_count :integer
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  owner_id    :integer
#
class Business < ApplicationRecord
  has_many :items, class_name: "Item", foreign_key: "business_id", dependent: :destroy
  belongs_to :owner, required: true, class_name: "User", foreign_key: "owner_id", counter_cache: true
end
