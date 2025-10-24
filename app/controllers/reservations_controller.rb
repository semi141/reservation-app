class ReservationsController < ApplicationController
  before_action :authenticate_user!  # ログイン必須

  def new
    @room = Room.find(params[:room_id])  # これでどの部屋か取得
    @reservation = current_user.reservations.new(room: @room)
  end

  def create
    @room = Room.find(params[:room_id])
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user
    if @reservation.save
      redirect_to @reservation, notice: '予約を作成しました。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm
    @room = Room.find(params[:reservation][:room_id])
    @reservation = @room.reservations.new(reservation_params)
    @reservation.user = current_user

    # バリデーションを実行
    if @reservation.valid?
      render :confirm
    else
      # エラーがある場合は入力画面に戻す
      render :new, status: :unprocessable_entity
    end
  end

  def index
    redirect_to my_reservations_path
  end

  def show
    # 他人の予約にはアクセスできないようにする
    @reservation = current_user.reservations.find(params[:id])
  end

  def edit
    @reservation = current_user.reservations.find(params[:id])
  end

  def update
    @reservation = current_user.reservations.find(params[:id])
    if @reservation.update(reservation_params)
      redirect_to @reservation, notice: '予約を更新しました。'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: '予約を削除しました。'
  end

  def my_reservations
    @reservations = current_user.reservations.includes(:room)
  end

  private

  def reservation_params
    params.require(:reservation).permit(:room_id, :check_in, :check_out, :number_of_people)
  end
end
