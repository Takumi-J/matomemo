class Admin::ForumsController < ApplicationController
  before_action :authenticate_admin!
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
  
  def destroy
    @forum = Forum.find(params[:id])
    @forum.destroy
    redirect_to admin_work_forums_path(params[:work_id])
  end
  
        private

  def forum_set_q
    @q = Forum.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end
end
