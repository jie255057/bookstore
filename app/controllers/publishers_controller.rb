class PublishersController < ApplicationController
  layout 'book'
  def show
    @publishers = Publisher.available
    @categories = Category.all

    @publisher  = Publisher.find(params[:id])
    @books = @publisher.books.page(params[:page])
  end
end
