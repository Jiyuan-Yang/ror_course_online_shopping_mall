class ShopsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]
  before_action :correct_user_seller, only: [:new, :create]

  protect_from_forgery :except => :index

  def new
    @shop = Shop.new
  end

  def show
    if params[:shop_id].nil?
      @shop = Shop.find(params[:id])
      @products = @shop.products.paginate(:page => params[:page], :per_page => 6)
    else
      @shop = Shop.find(params[:shop_id])
      @products = @shop.products.paginate(:page => params[:page], :per_page => 6)
    end

    # here could use user id because it's passed
    # but in `new` it couldn't be reached
  end

  # Attention: index is for all the pages `get /shops`, this is used by the admin

  def create
    # deal with the POST request
    # @shop = current_user.shops.build(shop_params)
    @shop = User.find(params[:id]).shops.build(shop_params)
    if @shop.save
      flash[:success] = "您的商店 \"#{shop_params[:name]}\" 已经创建!"
      redirect_to user_shop_path(params[:id]) # equals to `redirect_to user_url(@user)`
      # Attention shops_url is the overall view of shop, shop_url is the user's
    else
      render 'new'
    end
  end

  def destroy
    @shop = Shop.find(params[:shop_id])
    user_name = @shop.user.name
    shop_name = @shop.name
    @shop.destroy
    flash[:success] = "用户#{user_name}的商店#{shop_name}已经成功注销!"
    redirect_to(user_shop_path(params[:id]))
  end

  def graph
    @user = User.find(params[:id])
    @shop = Shop.find(params[:shop_id])
  end

  def monthly
    @shop = Shop.find(params[:shop_id])
    @user = User.find(params[:id])
    time = params[:time].to_s.split('-')
    year = time[0]
    month = time[1]
    number_of_days = days_in_month(year.to_i, month.to_i)
    @amount = Array.new(number_of_days, 0)
    @total_price = Array.new(number_of_days, 0)
    @days = (1..number_of_days).to_a
    @shop.products.each do |product|
      product.order_items.each do |shopping_item|
        order_time = shopping_item.created_at.to_date
        if year == order_time.year.to_s and month == order_time.month.to_s
          @amount[order_time.day] += shopping_item.amount
          @total_price[order_time.day] += shopping_item.total_price
        end
      end
    end
    (0..number_of_days - 1).each do |i|
      @amount[i] = @amount[i] / 2
      @total_price[i] = @total_price[i] / 2
    end
    print @amount
    print @total_price
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :description)
  end

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
