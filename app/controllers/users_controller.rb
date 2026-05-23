class UsersController < ApplicationController
  before_action :redirect_to_login

  def index
    @users = User.all  
    @book = Book.new   
  end

  def show
    # URLに含まれるIDを元にユーザーのデータを取得し、ビュー（show.html.erb）で利用できる
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless @user == current_user
  end

  # 更新を実行するアクション
  def update
    @user = User.find(params[:id])
    if @user != current_user
      redirect_to user_path(current_user)
      return
    end

    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  private

  def redirect_to_login
    redirect_to new_session_path unless user_signed_in?
  end
end
