class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]
  before_action :correct_user_seller, only: [:show_shops]
  before_action :correct_user_admin, only: [:destroy]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    # deal with the POST request
    @user = User.new(user_params)
    if @user.email.split('@')[1].downcase != 'jimstudio.com' and @user.character == 'administrator'
      flash[:danger] = "要想注册成为管理员，则必须使用内部工作人员的域名为jimstudio.com的邮箱"
      render("new")
      return
    end
    if @user.save
      if @user.character == "buyer"
        ShoppingCart.new(user_id: @user.id).save
        Favorite.new(user_id: @user.id).save
      end

      log_in(@user)
      flash[:success] = "欢迎登陆 Max Jim's"
      redirect_to(@user)
    else
      render("new")
    end
  end

  def show_shops
    @user = User.find(params[:id])
    @shops = @user.shops.paginate(:page => params[:page], :per_page => 8)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "成功修改!"
      redirect_to(@user)
    else
      render("edit")
    end
  end

  def destroy
    @user = User.find(params[:id])
    name = @user.name
    @user.destroy
    flash[:success] = "用户#{name}已经成功删除!"
    redirect_to(all_users_path)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :character, :password, :password_confirmation, :receiver_name, :receiver_address, :receiver_phone_number)

  end
end
