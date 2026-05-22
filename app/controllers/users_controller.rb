class UsersController < ApplicationController
  def index
  end

  def show
    # URLに含まれるIDを元にユーザーのデータを取得し、ビュー（show.html.erb）で利用できる
    @user = User.find(params[:id])
  end

  def edit
  end
end
