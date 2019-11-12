class ProductsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create]
  before_action :correct_user_seller, only: [:new, :create]


  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Shop.find(params[:shop_id]).products.build(product_params)
    if @product.save
      flash[:success] = "Your product \"#{product_params[:name]}\" is ready!"
      redirect_to show_shop_get_path # equals to `redirect_to user_url(@user)`
      # Attention shops_url is the overall view of shop, shop_url is the user's
    else
      render 'new'
    end
  end

  def show_one_category
    @products = Product.where("category=?", params[:category]).paginate(:page => params[:page], :per_page => 6)
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :category)
  end
end
