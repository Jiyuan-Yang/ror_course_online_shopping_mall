class SearchResultsController < ApplicationController
  protect_from_forgery :except => :search

  def search
    @keyword = params[:keyword]
    @product_result = []
    @shop_result = []
    Product.where("name like ? or description like ?", '%' + @keyword + '%', '%' + @keyword + '%').find_each do |item|
      @product_result.append(item)
    end
    Shop.where("name like ? or description like ?", '%' + @keyword + '%', '%' + @keyword + '%').find_each do |item|
      @shop_result.append(item)
    end
  end
end
