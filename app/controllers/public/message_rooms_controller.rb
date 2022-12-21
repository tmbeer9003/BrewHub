class Public::MessageRoomsController < ApplicationController
  before_action :authenticate_member!

  def create
    member = Member.find(params[:member_id])
    new_room = MessageRoom.create
    new_room.entries.create([{member_id: current_member.id}, {member_id: member.id}])
    redirect_to message_room_path(new_room)
  end

  def show
    @message_room = MessageRoom.find(params[:id])
    @member = @message_room.members.where.not(id: current_member.id).first
    # 相互フォローではなくなったユーザーとのメッセージルーム、他人のメッセージルームへの入室を防ぐ
    unless current_member.followed_each_other?(@member) && @message_room.members.exists?(id: current_member.id)
        redirect_to mypage_path, alert: "権限がありません"
    end
    @message = Message.new
    @messages = @message_room.messages.order("id DESC").page(params[:page]).per(20)
  end

  def index
    # messagesテーブルに結合
    message_rooms = current_member.message_rooms.eager_load(:messages)
    # message_roomsを直近でやりとりがされている順に並べ替え）
    @message_rooms = message_rooms.order('messages.created_at desc')
    # 各message_roomの相手ユーザーを取得
    members_all = @message_rooms.map do |room|
      room.members.where.not(id: current_member.id)
    end
    # members_allから相互フォローでないユーザーを除く
    members = members_all.flatten.map do |member|
      !member.followed_each_other?(current_member) ? member = nil : member
    end
    # membersからnilを除いて代入
    @members = Kaminari.paginate_array(members.compact).page(params[:page]).per(7)
  end
end