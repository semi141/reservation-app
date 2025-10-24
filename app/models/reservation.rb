class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validate :check_in_must_be_today_or_later
  validate :check_out_must_be_after_check_in
  validate :number_of_people_presence_and_numericality

  def stay_days
    return 0 unless check_in && check_out
    (check_out - check_in).to_i
  end

  def total_price
    return 0 unless check_in && check_out && room&.price

    stay_days * number_of_people * room.price
  end

  private

  def check_in_must_be_today_or_later
    if check_in.blank?
      errors.add(:check_in, "を入力してください")
    elsif check_in < Date.today
      errors.add(:check_in, "チェックインは本日以降の日付を選択してください")
    end
  end

  def check_out_must_be_after_check_in
    if check_out.blank?
      errors.add(:check_out, "を入力してください")
    elsif check_in.present? && check_out <= check_in
      errors.add(:check_out, "チェックアウトはチェックイン日より後の日付にしてください")
    end
  end

  # 空欄チェックと1以上チェックをまとめて同時にエラー表示できるように
  def number_of_people_presence_and_numericality
    if number_of_people.blank?
      errors.add(:number_of_people, "人数を入力してください")
    end

    if number_of_people.present? && number_of_people < 1
      errors.add(:number_of_people, "人数は1以上で入力してください")
    end
  end
end