module CartsHelper

  def find_cart_no_admin
    @cart = current_user.cart
    redirect_to root_path if is_admin?
  end

end
