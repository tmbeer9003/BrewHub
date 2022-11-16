class Public::MembersController < ApplicationController

  def index
    member_search = params[:member_search]
    if member_search == nil
      @members = Member.all
    else
      @members = Member.where("account_name like ?", "%#{member_search}%")
    end
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.save
      redirect_to request.referrer
    end
  end

end
