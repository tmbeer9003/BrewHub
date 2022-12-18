class Admin::GroupsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_group, only: [:show, :edit, :update, :destroy]
  layout "application_no_sidebar"

  def index
    # グループ検索で受け取った値を代入
    group_search = params[:group_search]
    unless group_search
      # 参加者が多い順に並べる
      groups = Group.includes(:members).sort { |a, b| b.members.size <=> a.members.size }
      @groups = Kaminari.paginate_array(groups).page(params[:page]).per(10)
    else
      groups = Group.where("name like ?", "%#{group_search}%").includes(:members).sort { |a, b| b.members.size <=> a.members.size }
      @groups = Kaminari.paginate_array(groups).page(params[:page]).per(10)
    end
  end

  def show
    # トピック検索で受け取った値を代入
    group_post_search = params[:group_post_search]
    unless group_post_search
      @group_posts = @group.group_posts.all.order(id: :desc).page(params[:page]).per(5)
    else
      @group_posts = @group.group_posts.where("title like ?", "%#{group_post_search}%").order(id: :desc).page(params[:page]).per(5)
    end
  end

  def edit
  end

  def update
    @group.update(group_params) ? (redirect_to admin_group_path(@group), success: "グループ情報を更新しました") : (render "error")
  end

  def destroy
    @group.destroy
    redirect_to admin_groups_path, alert: "グループを削除しました"
  end

  private
    def group_params
      params.require(:group).permit(:owner_id, :name, :description, :group_image)
    end

    def set_group
      @group = Group.find(params[:id])
    end
end
