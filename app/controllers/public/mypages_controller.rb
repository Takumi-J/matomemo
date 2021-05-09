class Public::MypagesController < ApplicationController
  before_action :authenticate_member!

  def index
    @member = current_member

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

    @to_mypage = "yes"

  end

  def show
    @review = Review.find(params[:id])
    @work = Work.find(@review.work_id)
    @to_mypage = "yes"
  end

  def with_tag
    @member = current_member

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

  def tag
   if !session[:category].blank?
    session.delete(:category)
   end

   session[:category] = work_mng_params[:category]
   @category = session[:category]
  end

  def favorite_forum
   @member = current_member
   @forums = ForumMng.where(member_id: @member.id,favorite: true).pluck(:forum_id)

   @works = []
   @forums.each do |forum|
    @work_id = Forum.find(forum).work_id
    @works.push(@work_id)
   end
  end

  def edit
   @member = current_member
  end

  def update
    @member = current_member
    @member.update(member_params)
    redirect_to mypages_path
  end

  def delete_check
    @member = current_member
  end

  def delete
    @member = current_member
    @member.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  def follow_index
   @members = Relationship.where(member_id: current_member.id).pluck(:follow_id)
  end

  def follow_review
   @members = Relationship.where(member_id: current_member.id).pluck(:follow_id)
   @reviews = []
   @members.each do |member|
     @reviews_ids = Review.where(member_id: member)
     @reviews_ids.each do |review|
       @reviews.push(review.id)
     end
   end
   @reviews.sort.reverse
  end

      private

  def member_params
    params.require(:member).permit(:name,:opinion,:email,:is_deleted)
  end

  def work_mng_params
    params.permit(:category)
  end

end
