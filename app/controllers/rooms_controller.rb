class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = Room.all

    if params[:area].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:area]}%")
    end

    if params[:address].present?
      @rooms = @rooms.where("address LIKE ?", "%#{params[:address]}%")
    end

    if params[:keyword].present?
      keyword = "%#{params[:keyword]}%"
      @rooms = @rooms.where("name LIKE ? OR description LIKE ?", keyword, keyword)
    end
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      redirect_to @room, notice: "施設を登録しました"
    else
      puts "ここに入った？"
      render :new
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path, notice: "施設を削除しました"
  end

  # rooms_controller.rb
  def my_rooms
    @rooms = current_user.rooms  # 自分の施設だけ取得
  end

  private

  def room_params
    params.require(:room).permit(:name, :detail, :price, :address, :image, :capacity)
  end
end
