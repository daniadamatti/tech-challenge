class Cart < ApplicationRecord
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  has_many :notifications, dependent: :destroy

  validates_numericality_of :total_price, greater_than_or_equal_to: 0

  def mark_as_abandoned
    update(abandoned_at: Time.current) unless abandoned?
    create_abandon_notification
  end

  def remove_if_abandoned
    destroy if abandoned_1week?
  end

  def abandoned?
    abandoned_at.present? && abandoned_at > 3.hour.ago
  end

  def abandoned_1week?
    abandoned_at.present? && abandoned_at > 1.week.ago
  end

  def add_product(product, quantity)
    current_item = cart_items.find_or_initialize_by(product_id: product.id)
    current_item.quantity ||= 0
    current_item.quantity += quantity  
    current_item.cart_id = id
  
    unless current_item.save
      raise StandardError, "Failed to save cart item: #{current_item.errors.full_messages.join(', ')}"
    end
  end

  private

  def create_abandon_notification
    Notification.create(cart_id: id, message: "Cart abandoned at #{abandoned_at}")
  end
end