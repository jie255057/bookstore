class Api::BooksController < ApplicationController
  before_action :login_check!

  def favorite
    book = Book.find(params[:id])
    
    fav = Favorite.find_by(user: current_user, book: book)
    favorited = false
    # fav = book.favorites.find_by(user: current_user)
    # fav = current_user.favorites.find_by(book: book)
    
    if fav
      fav.destroy
      favorited = false
    else
      current_user.favorites.create(book: book)
      favorited = true
    end

    render json: {status: 'ok', favorited: favorited}
  end

  private

  def login_check!
    if not user_signed_in?
      head 401
    end
  end
end
