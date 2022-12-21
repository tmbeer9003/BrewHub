class Public::MessagesController < ApplicationController
  before_action :authenticate_member!

  def create
    @message_room = MessageRoom.find(params[:message_room_id])
    @message = @message_room.messages.new(message_params)
    @message.member_id = current_member.id
    @messages = @message_room.messages.order("id DESC").page(params[:page]).per(20)
    render "error" unless @message.save
  end

  def destroy
    @message_room = MessageRoom.find(params[:message_room_id])
    @messages = @message_room.messages.order("id DESC").page(params[:page]).per(20)
    @message = Message.find(params[:id])
    @message.destroy
  end

  private
    def message_params
      params.require(:message).permit(:content)
    end
end