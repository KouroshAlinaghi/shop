class CartsController < ApplicationController
  include SessionsHelper
  include UsersHelper
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

  def find_cart_no_admin
    @cart = current_user.cart
    redirect_to root_path if is_admin?
  end

  def authorize_admin
    redirect_to root_path unless is_admin?
  end

end
