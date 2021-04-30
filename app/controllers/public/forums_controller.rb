class Public::ForumsController < ApplicationController
  before_action :authenticate_member!
  before_action :forum_set_q, only: [:index]

  def index
    @work = Work.find(params[:work_id])
    @forums = @work.forums
    @forums = Forum.page(params[:page])
  end

  def show
    @coment = Comment.new
    @forum = Forum.find(params[:id])
    @work = Forum.find(params[:work_id])
    @comments = Comment.where(forum_id: params[:id])
    @comments = Comment.page(params[:page])
  end

  def new
    @forum = Forum.new
    @work = Work.find(params[:work_id])
  end

  def create
    @forum = Forum.new(forum_params)
    @forum.save
    redirect_to work_forum_path(@forum.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end

      private

  def forum_params
    params.require(:forum).permit(:id, :work_id, :title, :summary, :member_id)
  end

  def forum_set_q
    @q = Forum.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end


end
