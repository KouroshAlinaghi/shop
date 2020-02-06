class ProductsController < ApplicationController
  include SessionsHelper
  include UsersHelper
  before_action :authorize_admin, only: [:create, :new, :destroy]
  before_action :authorize_user, only: [:toggle]

  def index
    @products = params[:search] ? Product.search(params[:search]) : Product.all
  end

  def show
    @product = Product.find(params[:id])
    @comments = @product.comments
  end

  def new
    @categories = Category.all.select { |cat| cat.subcategories.length == 0 }
    @product = Product.new
  end

  def create
    @categories = Category.all.select { |cat| cat.subcategories.length == 0 }
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render 'new'
    end
  end

  def edit
    @categories = Category.all.select { |cat| cat.subcategories.length == 0 }
    @product = Product.find(params[:id])
  end

  def update
    @categories = Category.all.select { |cat| cat.subcategories.length == 0 }
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to product_path @product
    else
      render 'edit'
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product_id = @product.id
    if @product.destroy
      Cart.all.each do |cart|
        cart.destroy if cart.products.all? { |product| product.id == @product_id } && !cart.orders.any?
      end
      flash.keep[:notice] = "Successfully deleted product!"
      redirect_to products_path
    else
      flash.keep[:error] = "Cannot Delete product"
    end
  end

  def toggle
    Cart.create(user_id: current_user.id) if current_user.cart.nil?
    @cart = Cart.find_by(user_id: current_user.id)
    @products = @cart.products
    @product = Product.find(params[:id])
    if @products.include?(@product)
      @products.destroy @product
    elsif @product.status
      @products << @product
    end
    if !@cart.nil?
      @cart.destroy unless @cart.products.any?
    end
    redirect_to product_path @product
  end

  protected

  def product_params
    params.require(:product).permit(:name, :price, :description, :photo, :category_id, :status)
  end

  def authorize_admin
    redirect_to root_path unless is_admin?
  end

  def authorize_user
    redirect_to root_path if current_user.nil?
  end

end
