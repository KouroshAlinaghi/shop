class UsersController < ApplicationController
  include UsersHelper
  before_action :authorize_admin, only: [:create_by_admins, :destroy]
  before_action :authorize_user, only: [:create, :new]
  before_action :is_logged_in, only: [:show]
    
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
      log_in @user 
      redirect_to root_path
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

  def authorize_admin
    return is_admin?
  end

  def authorize_user
    return current_user.nil?
  end

  def is_logged_in
    return !(current_user.nil?)
  end

end
