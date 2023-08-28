class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  #公開鍵を環境変数に設定
  before_action :set_gon, only: [:index, :create]

  def index
    #JavaScriptで変数が使用できるよう設定
    @order_payment = OrderPayment.new
  end

  def create
    @order_payment = OrderPayment.new(order_params)
    if @order_payment.valid?
      pay_item
      @order_payment.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def set_item
    #対象の商品を探し、購入済みか否かの判断を事前にberore_actionにて行う
    @item = Item.find(params[:item_id])
    redirect_to root_path if current_user.id == @item.user_id || @item.order.present?
  end

  def pay_item
    #秘密鍵を環境変数に設定
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,        # 商品の値段
      card: order_params[:token], # カードトークン
      currency: 'jpy'             # 通貨(日本円）
    )
  end

  def order_params
    params.require(:order_payment).permit(:postcode, :prefecture_id, :city, :block, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id],token: params[:token])
  end

  def set_gon
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  
end
