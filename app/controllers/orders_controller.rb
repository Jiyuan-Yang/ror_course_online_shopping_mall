class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:list_orders, :show, :destroy, :add_one_item_to_order, :add_items_in_shopping_cart_to_order]
  before_action :correct_user, only: [:list_orders, :destroy]

  def list_orders
    # @user = current_user
    @user = User.find(params[:id])
    @orders = @user.orders.paginate(:page => params[:page], :per_page => 8)
  end

  def show
    @order = Order.find(params[:id])
    @user = @order.user
    @order_items = @order.order_items
  end

  def destroy
    @item = Order.find(params[:order_id])
    order_id = @item.id
    @item.destroy
    Order.all.each do |item|
      if item.link_order_id == order_id
        item.destroy
      end
    end
    flash[:success] = "Order id #{order_id} deleted!"
    redirect_to(list_orders_path(id: params[:id]))
  end

  def add_one_item_to_order
    @product = Product.find(params[:id])
    @shop = Shop.find(@product.shop_id)
    @seller = User.find(@shop.user_id)
    lack_info = []
    if current_user.receiver_name.blank?
      lack_info.append('receiver_name')
    end
    if current_user.receiver_address.blank?
      lack_info.append('receiver_name')
    end
    if current_user.receiver_name.blank?
      lack_info.append('receiver_phone_number')
    end
    if lack_info != []
      flash[:danger] = "Please add your " + lack_info.inject { |all_info, info| all_info + ', ' + info }
    else
      @order_buyer = Order.new(receiver_name: current_user.receiver_name, receiver_address: current_user.receiver_address, receiver_phone_number: current_user.receiver_phone_number, order_time: Time.now, user_id: current_user.id)
      @order_buyer.save
      @order_seller = Order.new(link_order_id: @order_buyer.id, receiver_name: current_user.receiver_name, receiver_address: current_user.receiver_address, receiver_phone_number: current_user.receiver_phone_number, order_time: Time.now, user_id: @seller.id)
      @order_seller.save
      OrderItem.new(product_id: @product.id, amount: 1, order_id: @order_buyer.id).save
      OrderItem.new(product_id: @product.id, amount: 1, order_id: @order_seller.id).save
      flash[:success] = "it has been added to your order!"
    end
    redirect_to(@product)
  end

  def add_items_in_shopping_cart_to_order
    lack_info = []
    if current_user.receiver_name.blank?
      lack_info.append('receiver_name')
    end
    if current_user.receiver_address.blank?
      lack_info.append('receiver_name')
    end
    if current_user.receiver_name.blank?
      lack_info.append('receiver_phone_number')
    end
    if lack_info != []
      flash[:danger] = "Please add your " + lack_info.inject { |all_info, info| all_info + ', ' + info }
    else
      @shopping_cart = current_user.shopping_cart
      @order_buyer = Order.new(receiver_name: current_user.receiver_name, receiver_address: current_user.receiver_address, receiver_phone_number: current_user.receiver_phone_number, order_time: Time.now, user_id: current_user.id)
      @order_buyer.save
      created_order = Hash.new

      @shopping_cart.shopping_cart_items.each do |t|
        @product = t.product
        @shop = Shop.find(@product.shop_id)
        @seller = User.find(@shop.user_id)

        if !created_order.has_key?(@product.shop_id)
          @order_seller = Order.new(link_order_id: @order_buyer.id, receiver_name: current_user.receiver_name, receiver_address: current_user.receiver_address, receiver_phone_number: current_user.receiver_phone_number, order_time: Time.now, user_id: @seller.id)
          @order_seller.save
          created_order[@product.shop_id] = @order_seller.id
        end
        OrderItem.new(product_id: @product.id, amount: t.amount, order_id: @order_buyer.id).save
        OrderItem.new(product_id: @product.id, amount: t.amount, order_id: created_order[@product.shop_id]).save
        t.destroy
        flash[:success] = "it has been added to your order!"
      end
    end
    redirect_to(user_shopping_cart_path(current_user.id))
  end
end
