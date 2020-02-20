class OrdersController < ApplicationController
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

end

