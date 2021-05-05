class Public::OthersController < ApplicationController
  before_action :authenticate_member!
  
  def index
   @member = Member.find(params[:others_id])
   
   @anime = "アニメ"
   @movie = "映画"
   @drama = "ドラマ"
   @comic = "漫画"
   @novel = "小説"
   @all = "総合"

   @reviews_all = Review.where(member_id: @member.id)
   @work_all = @reviews_all.pluck(:work_id)
   @reviews = []

   if params[:g] == "アニメ"
     @work_all.each do |work|
       if Work.find(work).medium == "アニメ"
         @reviews.push(Review.find_by(work_id: work))
       end
     end
   elsif params[:g] == "映画"
     @work_all.each do |work|
       if Work.find(work).medium == "映画"
         @reviews.push(Review.find_by(work_id: work))
       end
     end
   elsif params[:g] == "ドラマ"
     @work_all.each do |work|
       if Work.find(work).medium == "ドラマ"
         @reviews.push(Review.find_by(work_id: work))
       end
     end
   elsif params[:g] == "漫画"
     @work_all.each do |work|
       if Work.find(work).medium == "漫画"
         @reviews.push(Review.find_by(work_id: work))
       end
     end
   elsif params[:g] == "小説"
     @work_all.each do |work|
       if Work.find(work).medium == "小説"
         @reviews.push(Review.find_by(work_id: work))
       end
     end
   else
     @reviews = Review.where(member_id: @member.id)
   end
   
  end
  
  def show
   @member = Member.find(params[:others_id])  
   @review = Review.find(params[:id])
   @work = Work.find(@review.work_id)
  end
  
  def with_tag
   @member = Member.find(params[:others_id])

   if session[:category].blank?
    @category = "お気に入り"
   else
    @category = session[:category]
   end

   @anime = "アニメ"
   @movie = "映画"
   @drama = "ドラマ"
   @comic = "漫画"
   @novel = "小説"
   @all = "総合"

   @work_mngs_all = WorkMng.where(member_id: @member.id,category: @category)
   @work_all = @work_mngs_all.pluck(:work_id)
   @works = []

   if params[:g] == "アニメ"
     @work_all.each do |work|
       if Work.find(work).medium == "アニメ"
         @works.push(work)
       end
     end
   elsif params[:g] == "映画"
     @work_all.each do |work|
       if Work.find(work).medium == "映画"
         @works.push(work)
       end
     end
   elsif params[:g] == "ドラマ"
     @work_all.each do |work|
       if Work.find(work).medium == "ドラマ"
         @works.push(work)
       end
     end
   elsif params[:g] == "漫画"
     @work_all.each do |work|
       if Work.find(work).medium == "漫画"
         @works.push(work)
       end
     end
   elsif params[:g] == "小説"
     @work_all.each do |work|
       if Work.find(work).medium == "小説"
         @works.push(work)
       end
     end
   else
    @works = @work_all
   end

  end
end
