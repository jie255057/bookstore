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

    def edit
      # @book = Book.find_by(id: params[:id])
      # redirect_to root_path unless @book, notice: '查無此書'
      @book = Book.find(params[:id])
    end

    def update
      @book = Book.find(params[:id])

      if @book.update(book_params)
        redirect_to root_path, notice: '更新成功'
      else
        render :edit
      end
    end
    


    # string parameters
    private
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
