class ChangeIsClosedToIsClosedFromOrder < ActiveRecord::Migration[6.0]
  def change
    change_column_default :orders, :is_closed, false
  end
end
