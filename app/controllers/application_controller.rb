class ApplicationController < ActionController::API
  before_action :current_cart

  private

  def current_cart
    @cart ||= Cart.find_or_create_by(id: session[:cart_id]) do |cart|
      cart.total_price = 0
    end
    session[:cart_id] = @cart.id
  end
end