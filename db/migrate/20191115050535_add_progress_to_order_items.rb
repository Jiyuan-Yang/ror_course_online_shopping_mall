class AddProgressToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :progress, :integer
  end
end
