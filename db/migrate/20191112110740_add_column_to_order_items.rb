class AddColumnToOrderItems < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :corresponding_id, :integer
  end
end
