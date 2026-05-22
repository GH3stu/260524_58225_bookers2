class BooksController < ApplicationController
  def create
    # 投稿データを受け取って保存する処理
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id) # 成功したら詳細画面へ
    else
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

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
