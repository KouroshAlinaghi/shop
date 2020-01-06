class CartsController < ApplicationController
  include SessionsHelper
  include UsersHelper
  before_action :find_cart, except: [:index]
  before_action :authorize_admin, only: [:index]
  before_action :authorize_user

  def index
    @carts = Cart.all
  end

  def show
  end

  def clear
    @cart.products.clear
    redirect_to carts_show_path
  end

  protected

  def cart_params
    params.require(:cart).permit(:user_id)
  end

  def find_cart
    @cart = current_user.cart
  end

  def authorize_admin
    redirect_to root_path unless is_admin?
  end

  def authorize_user
    redirect_to root_path if current_user.nil?
  end

end
