class CartsController < ApplicationController
  def add
    current_cart.add_item(params[:id])
    session['cart9527'] = current_cart.serialize

    redirect_to root_path, notice: 'ok'
  end
end
