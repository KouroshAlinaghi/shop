class UsersController < ApplicationController
  before_action :authorize_admin, only: [:create_by_admins, :destroy]
  before_action :authorize_not_signed_in, only: [:create, :new]
  before_action :authorize_user, only: [:show, :destroy, :edit, :update]
    
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
      respond_to do |format|
        format.html { redirect_to user_path(current_user) }
        format.json { head :no_content }
        format.js { render layout: false }
      end
    else
      render :show
    end
  end

  def create
    @user = User.new(user_params)
    @user.admin = false
    if @user.save
      log_in @user 
      redirect_to root_path
    else 
      render plain: "Wrong Args! :("
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
    @user.destroy

    respond_to do |format|
      format.html { redirect_to user_path(current_user) }
      format.json { head :no_content }
      format.js { render layout: false }
    end
  end
  
  protected

  def user_params
    params.require(:user).permit(:email, :username, :password_confirmation, :password, :admin)
  end

  def user_update_params
    params.require(:user).permit(:username)
  end

end
