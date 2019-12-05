class SearchResultsController < ApplicationController
  protect_from_forgery :except => :search

  @@pre_search_content = nil

  def search
    if params[:keyword].blank?
      if params.keys.count == 3
        redirect_to(root_path)
        return
      else
        if @@pre_search_content.nil?
          redirect_to(root_path)
        end
        @keyword = @@pre_search_content
      end
    else
      @keyword = params[:keyword]
      @@pre_search_content = params[:keyword]
    end
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
