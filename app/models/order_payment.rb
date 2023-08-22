class OrderPayment
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :building, :phone_number


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

    #先頭に０、後に1から９までの１０桁の数字のバリデーションを設定
    validates :phone_number, format: { with: /\A0\d{9,10}\z/, message: 'is invalid' }
    
  end
  
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(order_id: order.id, postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number)
  end



end