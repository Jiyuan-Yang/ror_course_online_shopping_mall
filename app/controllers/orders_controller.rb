class OrdersController < ApplicationController
  before_action :logged_in_user, only: [:list_orders, :show, :destroy,
                                        :add_one_item_to_order,
                                        :add_items_in_shopping_cart_to_order,
                                        :month_income, :year_income, :monthly, :month_average]
  before_action :correct_user, only: [:list_orders, :destroy, :month_income, :year_income,
                                      :monthly, :month_average]

  protect_from_forgery :except => :index

  @@pre_time_monthly = nil
  @@pre_time_month_average = nil
  @@pre_time_month_income = nil
  @@pre_time_year_income = nil

  def list_orders
    # @user = current_user
    @user = User.find(params[:id])
    @orders = @user.orders.paginate(:page => params[:page], :per_page => 6)
    @orders_not_finished = []
    @orders_finished = []
    @user.orders.each do |item|
      is_finished = true
      item.order_items.each do |sub_item|
        if sub_item.progress < 4
          is_finished = false
          break
        end
      end
      if is_finished
        @orders_finished.append(item)
      else
        @orders_not_finished.append(item)
      end
    end
  end

  def show
    @order = Order.find(params[:id])
    @user = @order.user
    @order_items = @order.order_items.paginate(:page => params[:page], :per_page => 6)
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
      @order_buyer = Order.new(receiver_name: current_user.receiver_name,
                               receiver_address: current_user.receiver_address,
                               receiver_phone_number: current_user.receiver_phone_number,
                               order_time: Time.now, user_id: current_user.id,
                               total_price: @product.price)
      @order_buyer.save
      @order_seller = Order.new(link_order_id: @order_buyer.id,
                                receiver_name: current_user.receiver_name,
                                receiver_address: current_user.receiver_address,
                                receiver_phone_number: current_user.receiver_phone_number,
                                order_time: Time.now, user_id: @seller.id,
                                total_price: @product.price)
      @order_seller.save
      @first = OrderItem.new(product_id: @product.id, amount: 1,
                             order_id: @order_buyer.id, progress: 0,
                             total_price: @product.price)
      @first.save
      @second = OrderItem.new(product_id: @product.id, amount: 1,
                              order_id: @order_seller.id, corresponding_id: @first.id, progress: 0,
                              total_price: @product.price)
      @second.save
      @first.update(:corresponding_id => @second.id)
      flash[:success] = "您已购买该商品！"
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
      @order_buyer = Order.new(receiver_name: current_user.receiver_name,
                               receiver_address: current_user.receiver_address,
                               receiver_phone_number: current_user.receiver_phone_number,
                               order_time: Time.now,
                               user_id: current_user.id)
      @order_buyer.save
      buyer_order_value_cnt = 0.0
      created_order = Hash.new
      order_seller_list = []

      @shopping_cart.shopping_cart_items.each do |t|
        @product = t.product
        @shop = Shop.find(@product.shop_id)
        @seller = User.find(@shop.user_id)

        if !created_order.has_key?(@product.shop_id)
          @order_seller = Order.new(link_order_id: @order_buyer.id,
                                    receiver_name: current_user.receiver_name,
                                    receiver_address: current_user.receiver_address,
                                    receiver_phone_number: current_user.receiver_phone_number,
                                    order_time: Time.now,
                                    user_id: @seller.id)
          order_seller_list.append(@order_seller)
          @order_seller.save
          created_order[@product.shop_id] = @order_seller.id
        end
        @first = OrderItem.new(product_id: @product.id, amount: t.amount,
                               order_id: @order_buyer.id, progress: 0,
                               total_price: t.amount * @product.price)
        @first.save
        @second = OrderItem.new(product_id: @product.id, amount: t.amount,
                                order_id: created_order[@product.shop_id],
                                corresponding_id: @first.id, progress: 0,
                                total_price: t.amount * @product.price)
        buyer_order_value_cnt += t.amount * @product.price
        @second.save
        @first.update(:corresponding_id => @second.id)
        t.destroy
        flash[:success] = "您已成功购买购物车中的商品！"
      end
      @order_buyer.update(total_price: buyer_order_value_cnt)
      order_seller_list.each do |item|
        seller_order_value_cnt = 0
        item.order_items.each do |sub_item|
          seller_order_value_cnt += sub_item.total_price
        end
        item.update(total_price: seller_order_value_cnt)
      end
    end
    redirect_to(user_shopping_cart_path(current_user.id))
  end

  def graph
    @user = User.find(params[:user_id])
    # print 'debug>>>>>>>>>', current_user, @user, current_user == @user
  end

  def monthly
    @user = User.find(params[:user_id])
    # print 'debug>>>>>>curuser', current_user.name
    if params[:time].blank?
      if params.keys.count == 4
        redirect_to(order_graph_path)
        return
      else
        if @@pre_time_monthly.nil?
          redirect_to(order_graph_path)
        end
        time = @@pre_time_monthly.to_s.split('-')
      end
    else
      time = params[:time].to_s.split('-')
      @@pre_time_monthly = params[:time]
    end
    year = time[0]
    month = time[1]
    number_of_days = days_in_month(year.to_i, month.to_i)
    @days = (1..number_of_days).to_a
    @quantity = []
    @number = []
    (1..number_of_days).each do |date|
      sum = 0
      number_day = 0
      Order.where(user_id: @user.id, order_time: year + '-' + month + '-' + date.to_s).find_each do |item|
        number_order = 0
        sum += item.total_price
        item.order_items.find_each do |order_item|
          number_order += order_item.amount
        end
        number_day += number_order
      end
      @number.append(number_day)
      @quantity.append(sum)
    end
  end

  def month_average
    @user = User.find(params[:user_id])
    if params[:time].blank?
      if params.keys.count == 4
        redirect_to(order_graph_path)
        return
      else
        if @@pre_time_month_average.nil?
          redirect_to(order_graph_path)
        end
        year = @@pre_time_month_average.to_s
      end
    else
      year = params[:time].to_s
      @@pre_time_month_average = params[:time]
    end
    @month = %w(01 02 03 04 05 06 07 08 09 10 11 12)
    @quantity = []
    @month.each do |month|
      sum = 0
      Order.where("user_id = :uid and order_time >= :s_time and order_time <= :e_time", {uid: @user.id, s_time: year + '-' + month + '-01', e_time: year + '-' + month + '-' + days_in_month(year.to_i, month.to_i).to_s}).find_each do |item|
        sum += item.total_price
      end
      puts sum
      @quantity.append(sum)
    end
    sum = 0
    (0..11).each do |i|
      sum += @quantity[i]
    end
    @avg = sum / 12
    puts @month
    puts @quantity
  end

  def category
    categories = Hash["clothes" => 0, "books" => 1, "office" => 2, "digital" => 3, "entertainment" => 4, "fruits_and_animals" => 5, "virtual_items" => 6]
    @sum = Array.new
    (0..6).each do |i|
      @sum[i] = 0
    end
    Order.where(user_id: params[:user_id]).find_each do |order|
      order.order_items.each do |item|
        product = item.product
        if categories.has_key?(product.category)
          @sum[categories[product.category]] += item.amount
        end
      end
    end
  end

  def month_income
    @user = User.find(params[:user_id])
    if params[:time].blank?
      if params.keys.count == 4
        redirect_to(order_graph_path)
        return
      else
        if @@pre_time_month_income.nil?
          redirect_to(order_graph_path)
        end
        time = @@pre_time_month_income.to_s.split('-')
      end
    else
      time = params[:time].to_s.split('-')
      @@pre_time_month_income = params[:time]
    end
    year = time[0]
    month = time[1]
    number_of_days = days_in_month(year.to_i, month.to_i)
    @days = (1..number_of_days).to_a
    @income = Array.new(number_of_days, 0)
    Order.where(user_id: @user.id).find_each do |order|
      order_time = order.order_time
      if year == order_time.year.to_s and month == order_time.month.to_s
        @income[(order_time.day) - 1] += order.total_price
      end
    end
    print @income
  end

  def year_income
    @user = User.find(params[:user_id])
    if params[:time].blank?
      if params.keys.count == 4
        redirect_to(order_graph_path)
        return
      else
        if @@pre_time_year_income.nil?
          redirect_to(order_graph_path)
        end
        year = @@pre_time_year_income.to_s
      end
    else
      year = params[:time].to_s
      @@pre_time_year_income = params[:time]
    end
    @income = Array.new(12, 0)
    Order.where(user_id: @user.id).find_each do |order|
      order_time = order.order_time
      if year == order_time.year.to_s
        @income[(order_time.month) - 1] += order.total_price
      end
    end
    print @income
    sum = 0
    (0..11).each do |i|
      sum += @income[i]
    end
    @avg = sum / 12
  end

  private

  def days_in_month(year, month)
    big = [1, 3, 5, 7, 8, 10, 12]
    small = [4, 6, 9, 11]
    if big.include?(month)
      return 31
    end
    if small.include?(month)
      return 30
    end
    if year % 4 == 0 && year % 100 != 0 || year % 400 == 0
      return 29
    else
      return 28
    end
  end

end
