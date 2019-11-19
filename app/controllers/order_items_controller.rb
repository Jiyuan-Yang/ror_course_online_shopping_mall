class OrderItemsController < ApplicationController
  def update_status
    @order_item = OrderItem.find(params[:order_item_id])
    @order = @order_item.order
    @user = User.find(@order.user_id)
    @another = OrderItem.find(@order_item.corresponding_id)
    @another_order = @another.order
    if @order_item.progress <= 3
      @order_item.progress += 1
      @another.progress += 1
    end
    @order_item.save
    @another.save
    redirect_to @order
  end

  def destroy
    @order_item = OrderItem.find(params[:order_item_id])
    @order = @order_item.order
    @user = User.find(@order.user_id)
    @another = OrderItem.find(@order_item.corresponding_id)
    @another_order = @another.order
    @order_item.destroy
    @another.destroy
    if @order.order_items.empty?
      @order.destroy
      redirect_to @user
      flash[:success] = "订单项和空订单已经成功删除!"
    else
      redirect_to @order
      flash[:success] = "订单项已经成功删除!"
    end
    if @another_order.order_items.empty?
      @another_order.destroy
    end
  end
end
