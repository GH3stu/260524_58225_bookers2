class UsersController < ApplicationController
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
  end

  # 更新を実行するアクション
  def update
    @user = User.find(params[:id])
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
end
