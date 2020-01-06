class ProductsController < ApplicationController
  include SessionsHelper
  include UsersHelper
  before_action :authorize_admin, only: [:create, :new, :destroy]
  before_action :authorize_user, only: [:toggle]

  def index
    @products = Product.all
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
    if @product.destroy
      flash.keep[:notice] = "Successfully deleted product!"
      redirect_to products_path
    else
      flash.keep[:error] = "Cannot Delete product"
    end
  end

  def toggle
    @product = Product.find(params[:id])
    !(@products.include? @product) ? @products << @product : @products.destroy(@product)
    redirect_to product_path @product
  end

  protected

  def product_params
    params.require(:product).permit(:name, :price, :description, :photo, :category_id)
  end

  def authorize_admin
    redirect_to root_path unless is_admin?
  end

  def authorize_user
    @products = current_user.cart.products
    redirect_to root_path if current_user.nil?
  end

end
