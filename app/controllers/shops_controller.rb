class ShopsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :correct_user_seller, only: [:new, :create]

  def new
    @shop = Shop.new
  end

  def show
    if params[:shop_id].nil?
      @shop = Shop.find(params[:id])
    else
      @shop = Shop.find(params[:shop_id])
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
      flash[:success] = "Your shop \"#{shop_params[:name]}\" is ready!"
      redirect_to user_shop_path(params[:id]) # equals to `redirect_to user_url(@user)`
      # Attention shops_url is the overall view of shop, shop_url is the user's
    else
      render 'new'
    end
  end

  private

  def shop_params
    params.require(:shop).permit(:name, :description)
  end
end
