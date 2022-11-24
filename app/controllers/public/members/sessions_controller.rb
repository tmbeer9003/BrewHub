# frozen_string_literal: true

class Public::Members::SessionsController < Devise::SessionsController
  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to mypage_path, notice: 'ゲストとしてログインしました'
  end
end
