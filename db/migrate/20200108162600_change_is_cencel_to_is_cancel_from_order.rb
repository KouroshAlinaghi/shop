class ChangeIsCencelToIsCancelFromOrder < ActiveRecord::Migration[6.0]
  def change
    rename_column :orders, :is_cencel, :is_cancel
  end
end
