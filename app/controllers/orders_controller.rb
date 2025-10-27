class OrdersController < ApplicationController
  before_action :authenticate_user!           # ログインしていないユーザーを弾く
  before_action :set_item                     # 対象の商品を取得
  before_action :move_to_root_if_invalid_user # 不正アクセス防止

  def index
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path, notice: '購入が完了しました。'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  # フォームオブジェクト用のストロングパラメータ
  def order_params
    params.require(:order_address).permit(
      :postal_code, :prefecture_id, :city, :addresses, :building, :phone_number
    ).merge(
      user_id: current_user.id,
      item_id: @item.id,
      token: params[:token] # Pay.jp 決済用トークン
    )
  end

  # 対象の商品を取得
  def set_item
    @item = Item.find(params[:item_id])
  end

  # 不正アクセス防止（出品者や売却済み商品には購入不可）
  def move_to_root_if_invalid_user
    if current_user == @item.user || @item.order.present?
      redirect_to root_path
    end
  end

  # 支払い処理（Pay.jp）
  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
