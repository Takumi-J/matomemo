class Public::ForumsController < ApplicationController
  before_action :authenticate_member!
  before_action :forum_set_q, only: [:index]
  
  def index
    @work = Work.find(params[:work_id])
    @forums = @work.forums
    @forums = Forum.page(params[:page])
  end
  
  def show
  end
  
  def new
  end
  
  def create
  end
  
  def edit
  end
  
  def update
  end
  
  def destroy
  end
  
      private

  def forum_params
    params.require(:forum).permit(:id, :work_id, :title, :summary)
  end
  
  def forum_set_q
    @q = Forum.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end


end
