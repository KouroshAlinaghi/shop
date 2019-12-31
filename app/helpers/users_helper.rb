module UsersHelper
  include SessionsHelper

  def is_admin?
    return current_user && current_user.admin
  end
end
