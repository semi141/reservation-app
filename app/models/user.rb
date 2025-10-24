class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :icon
  has_many :reservations, dependent: :destroy
  has_many :rooms, dependent: :destroy

  # 名前必須
  validates :name, presence: true

  # 確認用パスワードも必須にする場合
  validates :password_confirmation, presence: true, on: :create
end
