class CommentsController < ApplicationController
  before_action :authorize_user, only: [:new, :create, :destroy]
  before_action :authorize_admin_or_owner_for_comment, only: [:destroy]
  skip_before_action :verify_authenticity_token

  def index
    @product = Product.find(params[:product_id])
    @comments = @product.comments
  end 

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to product_comments_path(params[:product_id])
    else
      sredirect_to product_path(params[:product_id])
    end
  end

  def destroy
    @product = @comment.product
    if @comment.destroy
      flash.keep[:notice] = "Successfully deleted comment!"
      redirect_to product_path @product
    else
      flash.keep[:error] = "Cannot Delete comment"
    end
  end

  protected

  def comment_params
    params.require(:comment).permit(:body, :user_id, :product_id)
  end


end

