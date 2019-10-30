class OrdersController < ApplicationController
  def list_orders
    @user = current_user
  end

  def show
    @order = Order.find(params[:id])
    @user = @order.user
  end

  def add_one_item_to_order
    @product = Product.find(params[:id])
    @shop = Shop.find(@product.shop_id)
    @seller = User.find(@shop.user_id)
    @order_buyer = Order.new(    receiver_name: current_user.receiver_name,     receiver_address: current_user.receiver_address,     receiver_phone_number: current_user.receiver_phone_number,     order_time: Time.now,     user_id: current_user.id)
    @order_buyer.save
    @order_seller = Order.new(    receiver_name: current_user.receiver_name,     receiver_address: current_user.receiver_address,     receiver_phone_number: current_user.receiver_phone_number,     order_time: Time.now,     user_id: @seller.id)
    @order_seller.save
    OrderItem.new(    product_id: @product.id,     amount: 1,     order_id: @order_buyer.id).save
    OrderItem.new(    product_id: @product.id,     amount: 1,     order_id: @order_seller.id).save
    flash[:success] = "Successful!"
    redirect_to(@product)
  end

  def add_items_in_shopping_cart_to_order
    @shopping_cart = current_user.shopping_cart
    @order_buyer = Order.new(    receiver_name: current_user.receiver_name,     receiver_address: current_user.receiver_address,     receiver_phone_number: current_user.receiver_phone_number,     order_time: Time.now,     user_id: current_user.id)
    @order_buyer.save
    created_order = Hash.new

    @shopping_cart.shopping_cart_items.each do |t|
      @product = t.product
      @shop = Shop.find(@product.shop_id)
      @seller = User.find(@shop.user_id)

      if !created_order.has_key?(@product.shop_id)
        @order_seller = Order.new(        receiver_name: current_user.receiver_name,         receiver_address: current_user.receiver_address,         receiver_phone_number: current_user.receiver_phone_number,         order_time: Time.now,         user_id: @seller.id)
        @order_seller.save
        created_order[@product.shop_id] = @order_seller.id
      end

      OrderItem.new(      product_id: @product.id,       amount: 1,       order_id: @order_buyer.id).save
      OrderItem.new(      product_id: @product.id,       amount: 1,       order_id: created_order[@product.shop_id]).save
    end
  end
end
