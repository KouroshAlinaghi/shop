module UsersHelper
  include SessionsHelper

  def authorize_admin
    redirect_to root_path unless is_admin?
  end

  def authorize_not_signed_in
    redirect_to root_path unless current_user.nil?
  end

  def authorize_user
    redirect_to root_path unless logged_in? 
  end

  def is_admin?
    return current_user && current_user.admin
  end

end
