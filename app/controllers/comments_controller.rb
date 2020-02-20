class CommentsController < ApplicationController
  before_action :authorize_user, only: [:new, :create, :destroy]
  before_action :authorize_admin_or_owner, only: [:destroy]

  def index
    @product = Product.find(params[:product_id])
    @comments = @product.comments
  end 

  def show
    @comment = Comment.find(params[:id])
  end

  def new
    @comment = Product.find(params[:product_id]).comments.new
  end

  def create
    @product = Product.find(params[:product_id])
    @comment = @product.comments.new(comment_params)
    if @comment.save
      redirect_to product_path(@product)
    else
      render 'new'
    end
  end

  def destroy
    if @comment.destroy
      flash.keep[:notice] = "Successfully deleted comment!"
      redirect_to root_path
    else
      flash.keep[:error] = "Cannot Delete comment"
    end
  end

  protected

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end


end

