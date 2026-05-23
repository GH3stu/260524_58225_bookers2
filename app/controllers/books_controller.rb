class BooksController < ApplicationController
  before_action :redirect_to_login

  def create
    # 投稿データを受け取って保存する処理
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book) # 成功したら詳細画面へ
    else
      @books = Book.all
      render :index # 失敗したら一覧画面に戻す（※一覧画面が必要）
    end
  end

  def index
  @books = Book.all
  @book = Book.new # 新規投稿用
  end

  def show
  @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user == current_user
  end

def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book.id)
  else
    render :edit
  end
end

def destroy
  book = Book.find(params[:id])  # 削除したい本を見つける
  book.destroy                  # 削除する
  redirect_to books_path        # 一覧画面へリダイレクト
end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def redirect_to_login
    redirect_to new_session_path unless user_signed_in?
  end
end
