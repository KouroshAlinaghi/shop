class CartsController < ApplicationController
  before_action :find_cart_no_admin, except: [:index]
  before_action :authorize_admin, only: [:index]

  def index
    @carts = Cart.all
  end

  def show
    @order = Order.new
  end

  def clear
    @cart.orders.any? ? @cart.products = [] : @cart.destroy
    redirect_to carts_show_path
  end

  protected

  def cart_params
    params.require(:cart).permit(:user_id)
  end

end
