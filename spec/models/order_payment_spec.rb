require 'rails_helper'

RSpec.describe OrderPayment, type: :model do
  before do
    user = FactoryBot.create(:user)
    @order_payment = FactoryBot.build(:order_payment, user_id: user.id)
  end

  describe '配送先情報の保存' do
    context '配送先情報の保存ができるとき' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@order_payment).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @order_payment.user_id = 1
        expect(@order_payment).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @order_payment.item_id = 1
        expect(@order_payment).to be_valid
      end
      it '郵便番号が「3桁、ハイフン、4桁」の組み合わせであれば保存できる' do
        @order_payment.postcode = '111-1111'
        expect(@order_payment).to be_valid
      end
      it '都道府県が「---」以外かつ空でなければ保存できる' do
        @order_payment.prefecture_id = 1
        expect(@order_payment).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @order_payment.city = '山鹿市'
        expect(@order_payment).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @order_payment.block = 'やまが区111'
        expect(@order_payment).to be_valid
      end
      it '建物名が空でも保存できる' do
        @order_payment.building = nil
        expect(@order_payment).to be_valid
      end
      it '電話番号が10桁以上11桁以内の半角数値のみであれば保存できる' do
        @order_payment.phone_number = '09012345678'
        expect(@order_payment).to be_valid
      end
      #tokenのテスト追加
      it "priceとtokenがあれば保存ができること" do
        expect(@order_payment).to be_valid
      end
    end

    context '配送先情報の保存ができないとき' do
      it 'user_idが空だと保存できない' do
        @order_payment.user_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できない' do
        @order_payment.item_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @order_payment.postcode = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Postcode can't be blank", 'Postcode is invalid. Include hyphen(-)')
      end
      it '郵便番号にハイフンがないと保存できないこと' do
        @order_payment.postcode = 111111
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Postcode is invalid. Include hyphen(-)')
      end
      it '都道府県が「---」だと保存できないこと' do
        @order_payment.prefecture_id = 0
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '都道府県が空だと保存できないこと' do
        @order_payment.prefecture_id = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @order_payment.city = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @order_payment.block = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Block can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @order_payment.phone_number = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @order_payment.phone_number = '111 - 11111 - 1111'
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上あると保存できないこと' do
        @order_payment.phone_number = 11_111_111_111_111_11111
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include('Phone number is invalid')
      end
      #tokenのテストを追加
      it "tokenが空では登録できないこと" do
        @order_payment.token = nil
        @order_payment.valid?
        expect(@order_payment.errors.full_messages).to include("Token can't be blank")
      end
      
    end
  end
end