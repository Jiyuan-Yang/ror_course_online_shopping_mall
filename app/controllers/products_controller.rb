class ProductsController < ApplicationController
  def new
    @product = Product.new
  end

  def show
    @product = Product.find(params[:id])
  end

  def create
    @product = Shop.find(params[:id]).products.build(product_params)
    if @product.save
      flash[:success] = "Your product \"#{product_params[:name]}\" is ready!"
      redirect_to shop_path(params[:id]) # equals to `redirect_to user_url(@user)`
      # Attention shops_url is the overall view of shop, shop_url is the user's
    else
      render 'new'
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price)
  end
end
