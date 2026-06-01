class SearchesController < ApplicationController


  def search
    @range = params[:range]
    
    if @range == "User"
      @users = User.search_for(params[:word], params[:search])
    else
      @books = Book.search_for(params[:word], params[:search])
    end
    render "search"
  end

end
