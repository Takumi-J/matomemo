class Public::ActorsController < ApplicationController
  before_action :authenticate_member!
  before_action :set_q, only: [:index]
  
  def index
    @actors = Actor.all
  end
  
  def actor_works
    @actor = Actor.find(params[:id]).name
    @works_all = ActorMng.where(actor_id: params[:id]).pluck(:work_id)

    @anime = "アニメ"
    @movie = "映画"
    @drama = "ドラマ"
    @comic = "漫画"
    @novel = "小説"
    @all = "総合"

    @works = []

    if params[:g] == "アニメ"
      @works_all.each do |work|
        if Work.find(work).medium == "アニメ"
          @works.push(work)
        end
      end
    elsif params[:g] == "映画"
      @works_all.each do |work|
        if Work.find(work).medium == "映画"
          @works.push(work)
        end
      end
    elsif params[:g] == "ドラマ"
      @works_all.each do |work|
        if Work.find(work).medium == "ドラマ"
          @works.push(work)
        end
      end
    elsif params[:g] == "漫画"
      @works_all.each do |work|
        if Work.find(work).medium == "漫画"
          @works.push(work)
        end
      end
    elsif params[:g] == "小説"
      @works_all.each do |work|
        if Work.find(work).medium == "小説"
          @works.push(work)
        end
      end
    else
      @works = @works_all
    end
  end
  
        private

  def set_q
    @q = Actor.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end
  
end
