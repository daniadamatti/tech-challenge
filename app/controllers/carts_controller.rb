class CartsController < ApplicationController
  # POST /carts
  def create
    @cart = Cart.find_or_create_by(id: session[:cart_id])
    session[:cart_id] = @cart.id

    product = Product.find_by(id: params[:product_id])
    unless product
      render json: { error: 'Produto não encontrado' }, status: :not_found
      return
    end

    quantity = params[:quantity].to_i
    if quantity <= 0
      render json: { error: 'A quantidade do produto deve ser maior que zero' }, status: :unprocessable_entity
      return
    end

    begin
      @cart.add_product(product, quantity)
      render json: cart_json(@cart)
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end
  end

  # GET /carts
  def show
    @cart = Cart.find(params[:id])
    render json: cart_json(@cart)
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Carrinho não encontrado' }, status: :not_found
  end

  private

  def cart_json(cart)
    {
      id: cart.id,
      products: cart.cart_items.map { |item| cart_item_json(item) },
      total_price: calculate_total_price(cart)
    }
  end

  def cart_item_json(item)
    {
      id: item.product.id,
      name: item.product.name,
      quantity: item.quantity,
      unit_price: item.product.price,
      total_price: item.quantity * item.product.price
    }
  end

  def calculate_total_price(cart)
    cart.cart_items.sum { |item| item.quantity * item.product.price }
  end
end
