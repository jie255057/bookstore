class BooksController < ApplicationController
    
    def index
    end

    def new
    end

    def create
      render html: params
    end
end
