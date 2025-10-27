class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image  # ActiveStorage で画像を管理
  has_one :order
  # ActiveHash モデルとの紐づけ
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  # バリデーション
  with_options presence: true do
    validates :image
    validates :name
    validates :description
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :shipping_day_id
    validates :price
  end

  # ActiveHash の「---」を選ばせない
  with_options numericality: { other_than: 1, message: "を選択してください" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_id
    validates :prefecture_id
    validates :shipping_day_id
  end

  # 価格の制限
  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999,
              message: "は¥300〜¥9,999,999の範囲で入力してください"
            }
end
