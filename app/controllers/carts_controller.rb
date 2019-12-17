class CartsController < ApplicationController
  layout 'book'
  def add
    current_cart.add_item(params[:id])
    session['cart9527'] = current_cart.serialize

    redirect_to root_path, notice: 'ok'
  end

  def show
  end

  def destroy
    session['cart9527'] = nil
    redirect_to root_path, notice: '購物車已清空'
  end
end
