class OrdersController < ApplicationController
  include SessionsHelper
  include UsersHelper
  before_action :authorize_user
  before_action :authorize_cart, except: [:index]
  before_action :authorize_owner, only: [:destroy]
  before_action :filled_cart, only: [:new, :create]

  def index
    @orders = is_admin? ? Order.all.select { |o| !o.is_closed } : current_user.orders
  end

  def new
    @order = Order.new
    @products = current_user.cart.products
  end

  def create
    @product_ids = []
    @cart = current_user.cart
    @cart.products.each { |p| @product_ids << p.id }
    @order = Order.new(order_params)
    @order.product_ids = @product_ids
    if @order.save
      @cart.orders.any? ? @cart.products = [] : @cart.destroy
      redirect_to order_path @order
    else
      render 'new'
    end
  end

  def close
    @order = Order.find(params[:id])
    @order.is_closed = true
  end

  def cancel
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to root_path
  end

  def show
    @order = Order.find(params[:id])
  end

  def destroy
    @order = Order.find(params[:id])
    if @order.destroy
      redirect_to user_path current_user
    else
      redirect_to order_path @order
    end
  end

  protected

  def order_params
    params.require(:order).permit(:user_id, :cart_id, product_ids:[])
  end

  def authorize_admin
    redirect_to root_path unless is_admin?
  end

  def authorize_user
    redirect_to root_path if current_user.nil?
  end

  def authorize_owner 
    redirect_to root_path unless @order.user == current_user
  end

  def authorize_owner_or_admin
    redirect_to root_path unless is_admin? && current_user == Order.find(params[:id]).user
  end

  def authorize_cart
    redirect_to root_path if current_user.cart.nil? && is_admin?
  end

  def filled_cart
    redirect_to root_path unless current_user.cart.products.any?
  end

end

