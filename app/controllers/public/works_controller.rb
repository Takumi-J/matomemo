class Public::WorksController < ApplicationController
  before_action :work_set_q, only: [:index]
    
  def index
    @works = Work.all
    @works = Work.page(params[:page])
  end
  
  def show
    @work = Work.find(params[:id])
    @genres = @work.genre_mngs
    @actors = @work.actor_mngs
  end
  
    private
  
  def work_set_q
    @q = Work.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end
  
end
