class ProductsController < ApplicationController
  before_action :authorize_admin, only: [:create, :new, :destroy]
  def index
    @categories = Category.all
    @options_for_select = {"By Price": "price", "By Name": "name", "By Time": "created_at"}
    @products = Product.filter(params.slice(:status, :category_ids, :search, :lowest_price, :highest_price)).page(params[:page]).order("#{params[:order_by]} #{params[:order_by_option]}")
    @lowest_price = Product.all.map { |p| p.price } .min
    @highest_price = Product.all.map { |p| p.price } .max
  end

  def show
    @product = Product.find(params[:id])
    @comments = @product.comments
    @comment = Comment.new
  end

  def new
    @categories = Category.all
    @product = Product.new
  end

  def create
    @categories = Category.all
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render 'new'
    end
  end

  def edit
    @categories = Category.all
    @product = Product.find(params[:id])
  end

  def update
    @categories = Category.all
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

  protected

  def product_params
    params.require(:product).permit(:name, :price, :description, :photo, :category_id, :status)
  end

end
