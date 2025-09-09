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
end
