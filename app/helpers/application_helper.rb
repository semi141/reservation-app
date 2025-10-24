module ApplicationHelper
  def back_button(path, text = "戻る")
    link_to text, path, class: "btn btn-secondary"
  end

  def back_to_index_button(path)
    link_to "検索画面へ戻る", home_index_path, class: "btn btn-secondary"
  end

  def my_reservations_button
    link_to "マイ予約一覧", reservations_path, class: "btn btn-outline-primary"
  end

  def my_reservations_link
    content_tag(:li) do
      link_to "自分の予約一覧", reservations_path, class: "dropdown-item"
    end
  end

  # ページに置く用ボタン
  def my_rooms_button
    link_to "マイ施設一覧", my_rooms_path, class: "btn btn-outline-primary"
  end

  # ドロップダウンメニュー用
  def my_rooms_link
    content_tag(:li) do
      link_to "自分の施設一覧", my_rooms_path, class: "dropdown-item"
    end
  end
end