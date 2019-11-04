class AddLinkOrderIdToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :link_order_id, :integer
  end
end
