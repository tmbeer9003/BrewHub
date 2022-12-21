# frozen_string_literal: true

class Public::Members::SessionsController < Devise::SessionsController
  def guest_sign_in
    member = Member.guest
    sign_in member
    Relationship.find_or_create_by!(member_id: 1, follow_id: member.id)
    Relationship.find_or_create_by!(member_id: member.id, follow_id: 1)
    redirect_to mypage_path, notice: "ゲストとしてログインしました"
  end
end
