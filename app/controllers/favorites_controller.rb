class FavoritesController < ApplicationController

  def create
    @book = Book.find(params[:book_id]) # bookをインスタンス変数(@book)へ変更
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    # redirect_to を削除　非同期通信のため、リダイレクトは不要です。
  end

  def destroy
    @book = Book.find(params[:book_id]) # 同様に@bookへ変更
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    # redirect_to を削除　非同期通信のため、リダイレクトは不要です。
  end

end
