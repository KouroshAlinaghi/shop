module OrdersHelper
  def userable_status order
    return order.is_closed ? 'You Got and Paid That Already!' : 'Wait for it...'
  end
end
