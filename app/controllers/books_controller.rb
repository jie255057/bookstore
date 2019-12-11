class BooksController < ApplicationController
  before_action :find_book, only:[:show, :comment]
  layout 'book'
  def index
    @books = Book.available
                .with_attached_cover_image
                .page(params[:page])
                .per(3)
    @publishers = Publisher.available
    @categories = Category.all
  end

  def show
    @categories = Category.all
    @comment = Comment.new
    @comments = @book.comments.order(id: :desc)
  end

  def comment
    # @comment = Comment.new(comment_params, user: current_user, book: @book)
    @comment = @book.comments.build(comment_params)
    if @comment.save
      respond_to do |format|
        format.js{
          render 'comment', layout: false
        }
      end
      # render js: 'alert("hi");'
      # render json: {status:'ok'}
      # redirect_to @book, notice: '留言成功'
    else
      render js: 'alert("發生錯誤");'
    end
  end

  private
  def find_book
    @book = Book.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:title, :content)
                            .merge(user: current_user)
  end
end
