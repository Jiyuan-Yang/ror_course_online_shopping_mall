class OrderItemsController < ApplicationController
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
      flash[:success] = "the order_item and the empty order have been deleted successfully!"
    else
      redirect_to @order
      flash[:success] = "the order_item has been deleted successfully!"
    end
    if @another_order.order_items.empty?
      @another_order.destroy
    end
  end
end
