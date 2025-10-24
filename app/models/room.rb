class Room < ApplicationRecord
  belongs_to :user
  has_many :reservations, dependent: :destroy
  has_one_attached :image

  validates :name, :price, :address, :detail, presence: true
  validate :price_must_be_positive

  private

  def price_must_be_positive
    return if price.blank?  # 空欄の場合は presence のエラーに任せる
    if price < 1
      errors.add(:price, "は1以上で入力してください")
    end
  end
end
