class AddReceiverDetailsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :receiver_name, :string
    add_column :users, :receiver_address, :string
    add_column :users, :receiver_phone_number, :string
  end
end
