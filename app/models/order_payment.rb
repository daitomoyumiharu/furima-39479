class OrderPayment
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number, :token


  with_options presence: true do
    #order バリデーション
    validates :user_id
    validates :item_id
    #payment バリデーション
    validates :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :prefecture_id, numericality: {other_than: 0, message: "can't be blank"} 
    validates :city
    validates :block
    #validates :building 任意のデータはバリデーション不要

    #tokenのバリデーション(本来テーブルに存在しない為バリデーションは出来ないが、attr_accessor :tokenによりバリデーション可能)
    validates :token
   #先頭が0以外(国際電話)に対応かつ9桁以上11桁以下の電話番号を許可
    validates :phone_number, format: {  with: /\A[0-9]{11}\z/, message: 'is invalid' }
    
  end
  
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(order_id: order.id, postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number)
  end



end