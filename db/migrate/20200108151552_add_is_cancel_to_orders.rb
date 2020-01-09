class AddIsCancelToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :is_cencel, :boolean, default: false
  end
end
