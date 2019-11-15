class AddTotalPriceToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :total_price, :float
  end
end
