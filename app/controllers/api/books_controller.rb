class Api::BooksController < ApplicationController

  skip_before_action :verify_authenticity_token

  def favorite
    render json: {status: 'ok'}
  end
end
