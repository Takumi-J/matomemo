class Public::ForumsController < ApplicationController
  before_action :authenticate_member!
  before_action :forum_set_q, only: [:index]

  def index
    @work = Work.find(params[:work_id])
    if @work.forums != []
      @forums = @work.forums.page(params[:page])
    else
      @forums = []
    end
  end

  def show
    @work = Work.find(params[:work_id])
    @coment = Comment.new
    @forum = Forum.find(params[:id])
    @creater = Member.find(@forum.member_id).name
    @comments = Comment.where(forum_id: params[:id]).page(params[:page])
  end

  def new
    @forum = Forum.new
    @work = Work.find(params[:work_id])
  end

  def create
    @forum = Forum.new(forum_params)
    @forum.save
    redirect_to work_forum_path(params[:work_id],@forum.id)
  end

  def edit
    @forum = Forum.find(params[:id])
    @work = Work.find(params[:work_id])
  end

  def update
    @forum = Forum.find(params[:id])
    if @forum.update(forum_params)
      flash[:notice]="変更内容を保存しました"
      redirect_to work_forum_path(params[:work_id],params[:id])
    else
      render "edit"
    end
  end

  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy
    redirect_to work_forums_path(params[:work_id])
  end

  def favorite
    @favorite = ForumMng.new(forum_mng_params)
    if ForumMng.find_by(forum_id: @favorite.forum_id, member_id: @favorite.member_id) != nil
      ForumMng.find_by(forum_id: @favorite.forum_id, member_id: @favorite.member_id).update(forum_mng_params)
    else
      @favorite.save
    end

    redirect_to work_forum_path(params[:work_id],params[:id])
  end

      private

  def forum_params
    params.require(:forum).permit(:id, :work_id, :title, :summary, :member_id)
  end

  def forum_mng_params
    params.permit(:favorite, :forum_id, :member_id)
  end

  def forum_set_q
    @q = Forum.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end


end
