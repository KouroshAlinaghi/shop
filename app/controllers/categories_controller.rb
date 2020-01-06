class CategoriesController < ApplicationController
  include CategoriesHelper

  def index
    @parent_categories = Category.where(parent_id: nil)
    @categories = Category.all
    @group = set_groups
  end

  def new
    @categories = Category.all
    @category = Category.new
    @category.parent = Category.find(params[:id]) unless params[:id].nil?
  end

  def create
    @category = Category.new(category_params)
    @category.parent_id = nil if category_params[:is_parent] == '1'
    @category.parent = Category.find(params[:id]) unless params[:id].nil?
    if @category.save
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def show
    @category = Category.find(params[:id])
    @products = []
    if @category.subcategories.any?
      @category.subcategories.each do |cat|
        @products + cat.products
      end
    else
      @products = @category.products
    end

  end

  def destroy
    @category = Category.find(params[:id])
    if @category.destroy
      redirect_to categories_path
    else
      render 'new'
    end
  end

  protected

  def category_params
    params.require(:category).permit(:title, :parent_id, :is_parent)
  end

end
