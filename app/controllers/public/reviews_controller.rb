class Public::ReviewsController < ApplicationController
  before_action :authenticate_member!

  def index
    @work = Work.find(params[:work_id])
    @reviews =  Review.where(work_id: @work.id)
    @reviews_page = Review.where(work_id: @work_id).page(params[:page])
  end

  def new
    @work = Work.find(params[:work_id])
    if Review.find_by(member_id: current_member.id,work_id: params[:id])
      redirect_to edit_work_review_path(@work.id,Review.find_by(work_id: @work.id,member_id: current_member.id).id)
    end
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    begin
      @review.save
      redirect_to work_path(params[:work_id])
    rescue
      flash[:notice]="全ての項目を入力してください"
      redirect_to new_work_review_path(params[:work_id])
    end
  end

  def edit
    @review = Review.find(params[:id])
    @work = Work.find(params[:work_id])

    if params[:m].blank?
      @to_mypage = "no"
    else
      @to_mypage = "yes"
    end

  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:notice]="変更内容を保存しました"
      if params[:m] == "no"
        redirect_to work_path(params[:work_id])
      else
        redirect_to mypages_path
      end
    else
      render work_path(params[:work_id])
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    if params[:m].blank?
      redirect_to work_path(params[:work_id])
    else
      redirect_to mypages_path
    end
  end

  def favorite
    @favorite = ReviewMng.new(review_mng_params)

    if ReviewMng.find_by(review_id: @favorite.review_id, member_id: @favorite.member_id) != nil
      ReviewMng.find_by(review_id: @favorite.review_id, member_id: @favorite.member_id).update(review_mng_params)
    else
      @favorite.save
    end

    if params[:index].blank?
      redirect_to work_path(params[:id])
    else
      redirect_to work_reviews_path(params[:index])
    end

  end

        private

  def review_params
    params.require(:review).permit(:id ,:member_id ,:work_id, :score, :title, :sentence)
  end

  def review_mng_params
    params.permit(:favorite, :review_id, :member_id)
  end

end
