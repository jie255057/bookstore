class CategoriesController < ApplicationController
  layout 'book'
  def show
    @categories = Category.all

    @category  = Category.find(params[:id])
    @books = @category.books.page(params[:page])
  end
end
