class OrdersController < ApplicationController
  def show 
  end

  def add_one_item_to_order
    @product = Product.find(params[:id])
    @shop = Shop.find(@product.shop_id)
    @seller = User.find(@shop.user_id)
    @order_buyer = Order.new(receiver_name:current_user.receiver_name,receiver_address:current_user.receiver_address,receiver_phone_number:current_user.receiver_phone_number,order_time:Time.now,user_id:current_user.id)
    @order_buyer.save
    @order_seller = Order.new(receiver_name:current_user.receiver_name,receiver_address:current_user.receiver_address,receiver_phone_number:current_user.receiver_phone_number,order_time:Time.now,user_id:@seller.id)
    @order_seller.save
    OrderItem.new(product_id:@product.id,amount:1,order_id:@order_buyer.id).save
    OrderItem.new(product_id:@product.id,amount:1,order_id:@order_seller.id).save
    flash[:success] = "Successful!"
    redirect_to @product
  end 
end
