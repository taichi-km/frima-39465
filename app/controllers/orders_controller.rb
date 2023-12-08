class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
   
  def index
    if current_user == @item.user
      redirect_to root_path
    else
      if @item.order.present?
        redirect_to root_path
      else
        gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
        @order_shipping = OrderShipping.new
      end
    end
  end

  def create
    @order_shipping = OrderShipping.new(order_params)
    if @order_shipping.valid?
        pay_item
        @order_shipping.save
        redirect_to root_path
    else
        gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
        render :index, status: :unprocessable_entity
    end
  end

    private
    def order_params
      params.require(:order_shipping).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
    end

    def set_item
      @item = Item.find(params[:item_id])
    end

    def pay_item
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: order_params[:token],
        currency: 'jpy'
      )
    end

end
