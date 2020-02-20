module OrdersHelper

  def userable_status order
    return order.is_closed ? 'You Got and Paid That Already!' : 'Wait for it...'
  end

  def authorize_owner_for_orders
    redirect_to root_path unless @order.user == current_user
  end

  def authorize_owner_or_admin_for_orders
    redirect_to root_path unless is_admin? && current_user == Order.find(params[:id]).user
  end

  def authorize_cart
    redirect_to root_path if current_user.cart.nil? && is_admin?
  end

  def filled_cart
    redirect_to root_path unless current_user.cart.products.any?
  end

end
