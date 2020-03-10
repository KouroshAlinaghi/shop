class AddImpressionsCountToProduct < ActiveRecord::Migration[6.0]
  def change
    add_column :products, :impressions_count, :int
  end
end
