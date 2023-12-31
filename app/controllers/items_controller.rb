class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  #重複した処理を集約
  before_action :set_item, only: [:show, :edit , :update, :destroy]

  def index
    @items = Item.includes(:user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # ログインしているユーザーであればeditファイルが読み込み
    # itemが購入されているか判定を行う(@item.order.nil?でorderがない場合のみeditファイルを読み込む)
    if @item.user_id == current_user.id && @item.order.nil?
    else
      redirect_to root_path
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end


  def show
  end

  def destroy
    #ログイン状態のユーザーと一致している場合削除実行する
    if @item.user_id == current_user.id
      @item.destroy
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :description, :category_id, :item_status_id, :shipping_cost_id, :prefecture_id, :shipping_date_id, :price).merge(user_id: current_user.id)
  end
  
  def set_item
    @item = Item.find(params[:id])
  end

end
