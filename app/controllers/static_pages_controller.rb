class StaticPagesController < ApplicationController
  before_action :correct_user_admin, only: [:all_orders, :all_users, :all_shops]

  def home
  end

  def about
  end

  def contact
  end

  def help
  end

  def all_users

  end

  def all_shops

  end

  def all_orders

  end
end
