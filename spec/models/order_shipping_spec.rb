require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_shipping = FactoryBot.build(:order_shipping, user_id: @user.id, item_id: @item.id)
  end

  describe '商品購入必要事項' do
    context '商品購入ができる場合' do
      it 'すべてが正しく入力される' do
        expect(@order_shipping).to be_valid
      end
      it 'buildingが空でも購入できる' do
        @order_shipping.building = ''
        @order_shipping.valid?
        expect(@order_shipping).to be_valid
      end
    end
    context '商品購入ができない場合' do
      it 'tokenが空では購入できない' do
        @order_shipping.token = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空では購入できない' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが数字だけでは購入できない' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code input correctly")
      end
      it 'prefectureが未選択では出品できない' do
        @order_shipping.prefecture_id = 1
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'cityが空では購入できない' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空では購入できない' do
        @order_shipping.address = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numberが空では購入できない' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberにハイフンがあると購入できない' do
        @order_shipping.phone_number = "090-1234-5678"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number input correctly")
      end
      it 'phone_numberは10桁以上の半角数値でないと購入できない' do
        @order_shipping.phone_number = "090123456"
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number input correctly")
      end
      it 'phone_numberは11桁以内の半角数値でないと購入できない' do
        @order_shipping.phone_number = '090123456789'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number input correctly")
      end
      it 'user_idが空では購入できない' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空では購入できない' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end