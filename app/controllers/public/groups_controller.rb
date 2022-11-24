class Public::GroupsController < ApplicationController
    before_action :authenticate_member!
    before_action :set_group, only: [:show, :edit, :update, :destroy]
    before_action :ensure_owner, only: [:edit, :update, :destroy]

  def index
    group_search = params[:group_search]
    if group_search == nil
      groups = Group.includes(:members).sort {|a,b| b.members.size <=> a.members.size}
      @groups = Kaminari.paginate_array(groups).page(params[:page]).per(10)
    else
      groups = Group.where("name like ?", "%#{group_search}%").includes(:members).sort {|a,b| b.members.size <=> a.members.size}
      @groups = Kaminari.paginate_array(groups).page(params[:page]).per(10)
    end
  end

  def create
    @group = current_member.groups.new(group_params)
    @group.owner_id = current_member.id
    if current_member.save
      redirect_to group_path(@group), success: "グループを作成しました"
    else
      render "error"
    end
  end

  def show
    group_post_search = params[:group_post_search]
    if group_post_search == nil
      @group_posts = @group.group_posts.all.order(id: :desc).page(params[:page]).per(5)
    else
      @group_posts = @group.group_posts.where("title like ?", "%#{group_post_search}%").order(id: :desc).page(params[:page]).per(5)
    end
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def update
    if @group.update(group_params)
     redirect_to group_path(@group), success: "グループ情報を更新しました"
    else
      render "error"
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path, alert: "グループを削除しました"
  end

  private

  def group_params
    params.require(:group).permit(:owner_id, :name, :description)
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def ensure_owner
    unless @group.owner == current_member
    redirect_to group_path(@group)
    end
  end

end