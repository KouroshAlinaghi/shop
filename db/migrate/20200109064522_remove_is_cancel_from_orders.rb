class RemoveIsCancelFromOrders < ActiveRecord::Migration[6.0]
  def change

    remove_column :orders, :is_cancel, :boolean
  end
end
