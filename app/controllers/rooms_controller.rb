class RoomsController < ApplicationController
  before_action :set_room, only: [:show]
  before_action :set_users_room, only: [:edit, :update, :destroy]
  before_action :require_authentication, only: [:new, :edit, :create, :update, :destroy]
 
  def index
    @rooms = Room.all
  end

  def show
    if user_signed_in?
      @user_review = @room.reviews.find_or_initialize_by(user_id: current_user.id)
    end
  end

  def new
    @room = Room.new
  end
 
  def edit
  end
 
  def create
    @room = current_user.rooms.build(room_params)
 
    if @room.save
      redirect_to @room, notice: t('flash.notice.room_created')
    else
      render :new
    end
  end
 
  def update
    if @room.update(room_params)
      redirect_to @room, notice: t('flash.notice.room_updated')
    else
      render :edit
    end
  end
 
  def destroy
    @room.destroy
    redirect_to rooms_url
  end
 
  private
  def set_room
    @room = Room.find(params[:id])
  end

  def set_users_room
    @room = current_user.rooms.find(params[:id])
  end
 
  def room_params
    params.require(:room).permit(:title, :location, :description)
  end
end
