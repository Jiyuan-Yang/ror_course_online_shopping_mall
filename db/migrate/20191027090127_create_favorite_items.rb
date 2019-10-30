class CreateFavoriteItems < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_items do |t|
      t.integer :product_id
      t.integer :favorite_id

      t.timestamps
    end
  end
end
