class RemoveCartIdFromOrders < ActiveRecord::Migration[6.0]
  def change
    remove_column :orders, :cart_id, :integer
  end
end
