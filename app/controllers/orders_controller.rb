class OrdersController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @order = current_user.orders.build(order_params)

    current_cart.items.each do |item|
      @order.order_item.build(book: item.product,
                               quantity: item.quantity,
                               sell_price: item.product.sell_price)
    end
    
    if @order.save
      session['cart9527'] = nil
      redirect_to root_path, notice: '訂單成立摟～'
    else
      flash[:notice] = '欄位發生錯誤喔'
      render 'carts/checkout'
    end
  end

  private
  def order_params
    params.require(:order).permit(:recipient, :tel, :address, :note)
  end
end
