class Public::ReviewsController < ApplicationController
  before_action :authenticate_member!

  def index
    @work = Work.find(params[:work_id])
    @reviews =  Review.where(work_id: @work.id)
    @reviews_page = Review.where(work_id: @work_id).page(params[:page])
  end

  def new
    @review = Review.new
    @work = Work.find(params[:work_id])
  end

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to work_path(params[:work_id])
  end

  def edit
    @review = Review.find(params[:id])
    @work = Work.find(params[:work_id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice]="変更内容を保存しました"
      redirect_to work_path(params[:work_id])
    else
      render work_path(params[:work_id])
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to work_path(params[:work_id])
  end

  def favorite
  end

        private

  def review_params
    params.require(:review).permit(:id ,:member_id ,:work_id, :score, :title, :sentence)
  end

  def review_mng_params
    params.permit(:favorite, :review_id, :member_id)
  end

end
