class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :correct_user_seller, only: [:new, :create]

  protect_from_forgery :except => :index


  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Shop.find(params[:shop_id]).products.build(product_params)
    if @product.save
      flash[:success] = "您的商品 \"#{product_params[:name]}\" 已经上架!"
      redirect_to show_shop_get_path # equals to `redirect_to user_url(@user)`
      # Attention shops_url is the overall view of shop, shop_url is the user's
    else
      render 'new'
    end
  end

  def show_one_category
    @products = Product.where("category=?", params[:category]).paginate(:page => params[:page], :per_page => 6)
  end

  def monthly
    @product = Product.find(params[:product_id])
    time = params[:time].to_s.split('-')
    year = time[0]
    month = time[1]
    number_of_days = days_in_month(year.to_i, month.to_i)
    @amount = Array.new(number_of_days, 0)
    @total_price = Array.new(number_of_days, 0)
    @days = (1..number_of_days).to_a
    OrderItem.where(product_id: @product.id).find_each do |order_item|
      order_time = order_item.created_at.to_date
      if year == order_time.year.to_s and month == order_time.month.to_s
        @amount[(order_time.day) - 1] += order_item.amount
        @total_price[(order_time.day) - 1] += order_item.total_price
      end
    end
    (0..number_of_days - 1).each do |i|
      @amount[i] = @amount[i] / 2
      @total_price[i] = @total_price[i] / 2
    end
    print @amount
    print @total_price
  end

  def sales_ranking
    @user = User.find(params[:user_id])
    @amount = Hash.new
    @user.shops.each do |shop|
      shop.products.each do |product|
        product.order_items.each do |order_item|
          if @amount.has_key?(order_item.product_id)
            @amount[order_item.product_id] += order_item.amount
          else
            @amount[order_item.product_id] = order_item.amount
          end
        end
      end
    end
    print @amount
    @amount = @amount.sort { |a, b| a[1] <=> b[1] }
    print @amount
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category)
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
