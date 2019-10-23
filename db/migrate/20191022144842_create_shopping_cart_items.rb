class CreateShoppingCartItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_cart_items do |t|
      t.integer :product_id
      t.integer :amount
      t.integer :shopping_cart_id

      t.timestamps
    end
  end
end
