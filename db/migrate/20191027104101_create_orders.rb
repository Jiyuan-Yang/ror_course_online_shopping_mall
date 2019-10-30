class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :receiver_name
      t.string :receiver_address
      t.string :receiver_phone_number
      t.string :status
      t.date :order_time
      t.float :total_price
      t.integer :user_id

      t.timestamps
    end
  end
end
