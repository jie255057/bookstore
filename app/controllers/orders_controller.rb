class OrdersController < ApplicationController
  before_action :authenticate_user!

  layout 'book'

  def index
    @orders = current_user.orders.order(id: :desc)
  end

  def pay
  end

  def cancel
    order = current_user.orders.find_by(num: params[:id])
    order.cancel!
    redirect_to orders_path, notice:"訂單#{order.num}已取消"
  end
  
  def create
    @order = current_user.orders.build(order_params)

    current_cart.items.each do |item|
      @order.order_item.build(book: item.product,
                               quantity: item.quantity,
                               sell_price: item.product.sell_price)
    end
    
    if @order.save
      session['cart9527'] = nil
      redirect_to pay_order_path(@order.num), notice: '訂單成立摟～'
    else
      flash[:notice] = '欄位發生錯誤喔'
      redirect_to root_path
    end
  end

  private
  def order_params
    params.require(:order).permit(:recipient, :tel, :address, :note)
  end
end
