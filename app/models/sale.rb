# == Schema Information
#
# Table name: sales
#
#  id            :bigint           not null, primary key
#  quantity_sold :integer
#  total_price   :float
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  item_id       :integer
#  user_id       :integer
#
class Sale < ApplicationRecord
  belongs_to :item, required: true, class_name: "Item", foreign_key: "item_id", counter_cache: true
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id", counter_cache: true

  has_one :business, through: :item
  
  # NOTE: Great job on implementing model callbacks
  before_validation :set_total_price   # calculate price before saving
  validate :enough_stock               # make sure stock exists

  after_create :decrease_item_stock    # adjust inventory

  private

  def set_total_price
    return unless item.present? && quantity_sold.present?
    self.total_price = item.price * quantity_sold
  end

  def enough_stock
    if item.present? && quantity_sold.present? && quantity_sold > item.quantity_in_stock
      errors.add(:quantity_sold, "cannot be greater than available stock")
    end
  end

  def decrease_item_stock
    return unless item.present? && quantity_sold.present?

    item.with_lock do
      item.update!(quantity_in_stock: item.quantity_in_stock - quantity_sold)
    end
  end
end
