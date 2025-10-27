class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :nickname, presence: true
    validates :birthday, presence: true
    validates :last_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "全角文字を使用してください" }
    validates :first_name, presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: "全角文字を使用してください" }
    validates :last_name_kana, presence: true,format: { with: /\A[ァ-ヶー－]+\z/, message: "全角カタカナを使用してください" }
    validates :first_name_kana, presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "全角カタカナを使用してください" }
  end

  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i,
                                 message: 'は英字と数字の両方を含めて設定してください' }
end
