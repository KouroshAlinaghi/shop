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
    @comment = Comments.new
  end

  def create
    @comment = Comment.new(comment_params)
 
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
        format.js   { }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
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
    params.require(:comment).permit(:body, :user_id, :product_id)
  end


end

