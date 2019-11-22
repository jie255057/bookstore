class BooksController < ApplicationController
    
    def index
      @book = Book.all
    end

    def new
      @book = Book.new
    end

    def create
      
    @book = Book.new(book_params)
      
      if @book.save
        redirect_to root_path, notice: '新增成功'
      else
        render :new  #借 new.html.erb的畫面
        # redirect_to new_book_path, notice: '新增失敗'
      end
    end
    
    private
    # string parameters
    def book_params
        params.require(:book).permit(
                :title,
                :description,
                :list_price,
                :sell_price,
                :page_num,
                :isbn,
                :isbn13)
    end
end
