class OrdersController < ApplicationController

  def index
    @order_payment = OrderPayment.new(order_params)
  end
end
