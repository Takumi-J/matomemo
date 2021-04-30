class Public::CommentsController < ApplicationController
  before_action :authenticate_member!

  def create
    @work = Work.find(params[:work_id])
    @forum = Forum.find(params[:forum_id])
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to "/works/#{@work.id}/forums/#{@forum.id}"
  end

        private

  def comment_params
    params.permit(:id, :member_id, :forum_id, :opinion)
  end

end
