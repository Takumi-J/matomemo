class Public::WorksController < ApplicationController
  before_action :authenticate_member!
  before_action :work_set_q, only: [:index]
    
  def index
    @works = Work.all
    @works = Work.page(params[:page])
  end
  
  def show
    @work = Work.find(params[:id])
    @genres = @work.genre_mngs
    @actors = @work.actor_mngs
    if current_member.work_mngs != nil
      @categories = current_member.work_mngs
      if @categories.find_by(work_id: @work.id) != nil
        @category = @categories.find_by(work_id: @work.id).category
      end
    else
      @category = []
    end
  end
  
  def category_create
    begin
      @category = WorkMng.new(work_mng_params)
      
      if WorkMng.find_by(work_id: @category.work_id, member_id: @category.member_id) != nil
        WorkMng.find_by(work_id: @category.work_id, member_id: @category.member_id).update(work_mng_params)
      else
        @category.save
      end
      
      redirect_to work_path
      
    rescue
      redirect_to work_path
    end
  end
  
    private
    
  def work_mng_params
    params.permit(:category, :work_id, :member_id)
  end
  
  def work_set_q
    @q = Work.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end
  
end
