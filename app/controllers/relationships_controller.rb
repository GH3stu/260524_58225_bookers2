class RelationshipsController < ApplicationController

  def create
    current_user.relationships.create(followed_id: params[:user_id])
    redirect_to request.referer
  end

  def destroy
    relationship = current_user.relationships.find_by(followed_id: params[:user_id])
    relationship.destroy if relationship
    redirect_to request.referer
  end

  # RelationshipsController
  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings # フォローしているユーザーを取得
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers # フォロワーを取得
  end
end
