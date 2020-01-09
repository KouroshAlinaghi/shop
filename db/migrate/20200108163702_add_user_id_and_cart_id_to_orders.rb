class AddUserIdAndCartIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :user_id, :integer
    add_column :orders, :cart_id, :integer
  end
end
