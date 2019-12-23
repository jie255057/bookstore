class OrdersController < ApplicationController
  before_action :authenticate_user!

  layout 'book'

  def index
    @orders = current_user.orders.order(id: :desc)
  end

  def pay
    @token = gateway.client_token.generate
    @order = current_user.orders.find_by(num: params[:id])
  end

  def paid
    nonce = params[:nonce]
    order = current_user.orders.find_by(num: params[:id])
    
    result = gateway.transaction.sale(
      amount: order.total_price,
      payment_method_nonce: nonce,
      :options => {
        :submit_for_settlement => true
      }
    )

    if result.success?
      order.pay!
      redirect_to orders_path, notice:'交易完成！'
    else
      redirect_to orders_path, notice:'交易發生錯誤! #{result.transaction.status}'
    end
  end

  def cancel
    order = current_user.orders.find_by(num: params[:id])
    order.cancel! if order.may_cancel?

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

  def gateway
    gateway = Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV['braintree_merchant_id'],
      public_key: ENV['braintree_public_key'],
      private_key: ENV['braintree_private_key']
    )
  end
end
