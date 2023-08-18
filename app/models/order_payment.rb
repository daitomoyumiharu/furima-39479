class OrderPayment
  include ActiveModel::model
  attr_accessor :user_id, :item_id, :postcode, :prefecture_id, :city, :block, :bulding, :phone_number


  with_options presence: true do
    #order バリデーション
    valid :user_id
    valid :item_id
    #payment バリデーション
    valid :postcode, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    valid :prefecture_id, numericality: {other_than: 0, message: "can't be blank"} 
    valid :city
    valid :block
    valid :bulding
    validates :phone_number, format: {
      with: /\A\d{3}-\d{4}-\d{4}\z/,
      message: "フォーマットが正しくありません。例: 123-4567-8901"
    }
    
  end
  
  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Payment.create(order_id: order.id, postcode: postcode, prefecture_id: prefecture_id, city: city, block: block, building: building, phone_number: phone_number)
  end



end