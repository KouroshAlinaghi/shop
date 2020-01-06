class UsersController < ApplicationController
  include SessionsHelper
  include UsersHelper
  before_action :authorize_admin, only: [:create_by_admins, :destroy]
  before_action :authorize_user, only: [:create, :new]
  before_action :login, only: [:show, :destroy, :edit, :update]
    
  def new
    @user = User.new
  end

  def show
    @users, @new_user = User.all, User.new if is_admin?
    @user = current_user
  end

  def create_by_admins
    @user = User.new(user_params)
    if @user.save
      Cart.create(user_id: @user.id)
      flash.keep[:notice] = "Successfully created user"
    else
      render :show
    end
  end

  def create
    @user = User.new(user_params)
    if params[:admin] || !@user.save
      render 'new'
    elsif @user.save
      Cart.create(user_id: @user.id)
      log_in @user 
      redirect_to root_path
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_update_params)
      redirect_to user_path @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash.keep[:notice] = "Successfully deleted user!"
    else
      flash.keep[:error] = "Cannot Delete User"
    end
  end
  
  protected

  def user_params
    params.require(:user).permit(:email, :username, :password_confirmation, :password, :admin)
  end

  def user_update_params
    params.require(:user).permit(:username)
  end

  def authorize_admin
    redirect_to root_path unless is_admin?
  end

  def authorize_user
    redirect_to root_path unless current_user.nil?
  end

  def login
    redirect_to root_path if current_user.nil?
  end

end
