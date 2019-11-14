class SearchResultsController < ApplicationController
  protect_from_forgery :except => :search
  def search
    @keyword = params[:keyword]
    @product_result = []
    @shop_result = []
    Product.all.each do |item|
      if item.name == @keyword
        @product_result.append(item)
      end
    end
    Shop.all.each do |item|
      if item.name == @keyword
        @shop_result.append(item)
      end
    end
  end
end
