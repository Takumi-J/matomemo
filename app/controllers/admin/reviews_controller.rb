class Admin::ReviewsController < ApplicationController
  before_action :authenticate_admin!
  
  def index
    @work = Work.find(params[:work_id])
    @reviews =  Review.where(work_id: @work.id)
    @reviews_page = Review.where(work_id: @work_id).page(params[:page])
  end
  
  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to admin_work_path(params[:work_id])
  end
end
