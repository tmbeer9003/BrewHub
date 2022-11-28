class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!
  layout "application_no_sidebar"

  def index
    member_search = params[:member_search]
    # 会員検索で受け取った値を代入
    unless member_search.nil?
      @members = Member.where("account_name like ?", "%#{member_search}%").page(params[:page]).per(10)
    else
      @members = Member.all.page(params[:page]).per(10)
    end
  end

  def show
    @member = Member.find(params[:id])
    post_search = params[:post_search]
    # 投稿検索で受け取った値を代入
    unless post_search.nil?
      @posts = @member.posts.where("content like ?", "%#{post_search}%").order(id: :desc).page(params[:page]).per(7)
    else
      @posts = @member.posts.order(id: :desc).page(params[:page]).per(7)
    end
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    (redirect_to edit_admin_member_path(@member), notice: "管理者権限で会員情報を変更しました") if @member.update(member_params)
  end

  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to admin_members_path, alert: "管理者権限で会員を削除しました"
  end

  private

  def member_params
    params.require(:member).permit(:account_name, :display_name, :email, :member_image, :introduction, :my_beer_style1_id, :my_beer_style2_id, :my_beer_style3_id, :my_beer_style4_id)
  end
end
