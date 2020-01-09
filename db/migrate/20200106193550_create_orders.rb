class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.decimal :price
      t.boolean :is_closed

      t.timestamps
    end
  end
end
