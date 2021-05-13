class Admin::WorksController < ApplicationController
  before_action :authenticate_admin!
  before_action :work_set_q, only: [:index]
  before_action :actor_set_q, only: [:new_2,:new_2_1,:edit_2,:edit_2_1]
  before_action :genre_set_q, only: [:new_3,:new_3_1,:edit_3,:edit_3_1]

  def index
    @works_all = Work.all.pluck(:id)

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

  def show
    @work = Work.find(params[:id])
    @genres = @work.genre_mngs.pluck(:genre_id)

    if @work.medium != "小説" or @work.medium != "漫画"
      @actors = @work.actor_mngs.pluck(:actor_id)
    end

    @reviews_all = Review.where(work_id: @work.id)
    @reviews =  Review.where(work_id: @work.id).order('updated_at DESC').limit(5)

    if @reviews != []
      scores = @reviews_all
      @score_avg = scores.sum { |i| i[:score]} / Review.where(work_id: @work.id).count
    else
      @score_avg = 0
    end
  end

  def new
   @work = Work.new
  end

  def new_2
   # 次のステップで表示するformに必要な情報を用意
    @work = Work.new(work_params)
    @actors = Actor.all
    @actors = Actor.page(params[:page])
    @checked_actors = []

   #入力漏れ防止
   if work_params[:title].blank? or
      work_params[:medium].blank? or
      work_params[:source].blank? or
      work_params[:author].blank? or
      work_params["release_date(1i)"].blank? or
      work_params["release_date(2i)"].blank? or
      work_params["release_date(3i)"].blank? or
      work_params[:synopsis].blank? or
      @work.image.url.blank? or
      @work.image.cache_name.blank?

     flash[:notice] ="必要項目を全て入力してください"
     redirect_to new_admin_work_path
   end

    # form からの情報をセッションに一時保存
    session[:title] = work_params[:title]
    session[:medium] = work_params[:medium]
    session[:source] = work_params[:source]
    session[:author] = work_params[:author]
    session[:release_date_1i] = work_params["release_date(1i)"]
    session[:release_date_2i] = work_params["release_date(2i)"]
    session[:release_date_3i] = work_params["release_date(3i)"]
    session[:synopsis] = work_params[:synopsis]
    session[:image_url] = @work.image.url
    session[:image_cache_name] = @work.image.cache_name

    if session[:medium]  == "漫画" or session[:medium] == "小説"
      redirect_to new_3_admin_works_path
    end
  end

  def new_2_1
    # 登録した出演者の情報をsessionに保存する
    if session[:actors] == nil
      session[:actors] = []
    end

    if work_params[:is_deleted_all] == "true"
      session.delete(:actors)

    elsif work_params[:is_deleted].blank? == false
      session[:actors].delete(work_params[:is_deleted])

    elsif params[:q].blank? or params[:q][:is_search] != "true"
      # 出演者がすでに登録済みの場合は弾く
      if session[:actors].include?(work_params[:actor]) == false
       session[:actors].push(work_params[:actor])
      end

    end

    # 次のステップで表示するformに必要な情報を用意
    @work = Work.new
    @actors = Actor.all
    @actors = Actor.page(params[:page])
    @checked_actors = session[:actors]

    # もう一度同じviewをレンダリングする
    render "new_2"

  end

  def new_3
   # 出演者の入力漏れ防止
   if session[:actors].blank?
    flash[:notice] ="出演者を入力してください"
    # 次のステップで表示するformに必要な情報を用意
    @work = Work.new
    @actors = Actor.all
    @actors = Actor.page(params[:page])
    @checked_actors = session[:actors]
    render "new_2"
   end
   
    # 次のステップで表示するformに必要な情報を用意
    @work = Work.new
    @genres = Genre.all
    @genres = Genre.page(params[:page])
    @checked_genres = []
    
  end

  def new_3_1
    # 登録したジャンルの情報をsessionに保存する
    if session[:genres] == nil
      session[:genres] = []
    end

    if work_params[:is_deleted_all] == "true"
      session.delete(:genres)

    elsif work_params[:is_deleted].blank? == false
      session[:genres].delete(work_params[:is_deleted])

    elsif params[:q].blank? or params[:q][:is_search] != "true"
      # ジャンルがすでに登録済みの場合は弾く
      if session[:genres].include?(work_params[:genre]) == false
       session[:genres].push(work_params[:genre])
      end

    end

    # 次のステップで表示するformに必要な情報を用意
    @work = Work.new
    @genres = Genre.all
    @genres = Genre.page(params[:page])
    @checked_genres = session[:genres]

    # もう一度同じviewをレンダリングする
    render "new_3"

  end

  def new_confirm
   # ジャンルの入力漏れ防止
   if session[:genres].blank?
    flash[:notice] ="ジャンルを入力してください"
    redirect_to new_3_admin_works_path
   end
   
    @work = Work.new(
     title: session[:title],
     medium: session[:medium],
     source: session[:source],
     author: session[:author],
     release_date: Date.parse(session[:release_date_1i]+"-"+session[:release_date_2i]+"-"+session[:release_date_3i]),
     synopsis: session[:synopsis],
     )

    @image_url = session[:image_url]
    @image_cache_name = session[:image_cache_name]

    @actors = session[:actors]
    @genres = session[:genres]

  end

  def create
    @work = Work.new(work_params)
    @work.image.retrieve_from_cache! params[:cache][:image]

    if @work.save
     if @work.medium != "漫画" and @work.medium != "小説"
      # 作品と出演者の中間テーブルの作成
      session[:actors].each do|actor|
       @actor_mng = ActorMng.new(
         work_id: @work.id,
         actor_id: actor
        )
       @actor_mng.save
      end
     end

       # 作品とジャンルの中間テーブルの作成
      session[:genres].each do|genre|
       @genre_mng = GenreMng.new(
         work_id: @work.id,
         genre_id: genre
        )
       @genre_mng.save
      end

      # sessin を全て空にする
      session.delete(:title)
      session.delete(:medium)
      session.delete(:source)
      session.delete(:author)
      session.delete(:release_date)
      session.delete(:synopsis)
      session.delete(:image_url)
      session.delete(:image_cache_name)
      session.delete(:actors)
      session.delete(:genres)

      redirect_to admin_work_path(@work.id)
    else
      render new_admin_work_path
    end

  end

  def edit
    @before_work = Work.find(params[:id])
    session[:id] = params[:id]
    @work = Work.new
  end

  def edit_2
    #入力漏れ防止
    if work_params[:title].blank? or
       work_params[:medium].blank? or
       work_params[:source].blank? or
       work_params[:author].blank? or
       work_params["release_date(1i)"].blank? or
       work_params["release_date(2i)"].blank? or
       work_params["release_date(3i)"].blank? or
       work_params[:synopsis].blank?

      flash[:notice] ="必要項目を全て入力してください"
      redirect_to new_admin_work_path
    end

    @actors = Actor.all
    @actors = Actor.page(params[:page])
    @checked_actors = Work.find(session[:id]).actor_mngs.pluck(:actor_id)
    session[:actors] = @checked_actors.map(&:to_s)

    # 次のステップで表示するformに必要な情報を用意
    @work = Work.new(work_params)

    # form からの情報をセッションに一時保存
    session[:title] = work_params[:title]
    session[:medium] = work_params[:medium]
    session[:source] = work_params[:source]
    session[:author] = work_params[:author]
    session[:release_date_1i] = work_params["release_date(1i)"]
    session[:release_date_2i] = work_params["release_date(2i)"]
    session[:release_date_3i] = work_params["release_date(3i)"]
    session[:synopsis] = work_params[:synopsis]
    session[:image_url] = @work.image.url
    session[:image_cache_name] = @work.image.cache_name

    if session[:medium]  == "漫画" or session[:medium] == "小説"
      redirect_to edit_3_admin_works_path
    end

  end

  def edit_2_1
     # 登録した出演者の情報をsessionに保存する
    if session[:actors] == nil
      session[:actors] = []
    end

    if work_params[:is_deleted_all] == "true"
      session.delete(:actors)

    elsif work_params[:is_deleted].blank? == false
      session[:actors].delete(work_params[:is_deleted])

    elsif params[:q].blank? or params[:q][:is_search] != "true"
      # 出演者がすでに登録済みの場合は弾く
      if session[:actors].include?(work_params[:actor]) == false
       session[:actors].push(work_params[:actor])
      end

    end

    # 次のステップで表示するformに必要な情報を用意
    @work = Work.new
    @actors = Actor.all
    @actors = Actor.page(params[:page])
    @checked_actors = session[:actors]

    # もう一度同じviewをレンダリングする
    render "edit_2"

  end

  def edit_3
    # 次のステップで表示するformに必要な情報を用意
    @before_work = Work.find(session[:id])
    @work = Work.new
    @genres = Genre.all
    @genres = Genre.page(params[:page])
    @checked_genres = @before_work.genre_mngs.pluck(:genre_id)
    session[:genres] = @checked_genres.map(&:to_s)
  end

  def edit_3_1
    # 登録したジャンルの情報をsessionに保存する
    if session[:genres] == nil
      session[:genres] = []
    end

    if work_params[:is_deleted_all] == "true"
      session.delete(:genres)

    elsif work_params[:is_deleted].blank? == false
      session[:genres].delete(work_params[:is_deleted])

    elsif params[:q].blank? or params[:q][:is_search] != "true"
      # ジャンルがすでに登録済みの場合は弾く
      if session[:genres].include?(work_params[:genre]) == false
       session[:genres].push(work_params[:genre])
      end

    end

    # 次のステップで表示するformに必要な情報を用意
    @work = Work.new
    @genres = Genre.all
    @genres = Genre.page(params[:page])
    @checked_genres = session[:genres]

    # もう一度同じviewをレンダリングする
    render "edit_3"
  end

  def edit_confirm
    @before_work = Work.find(session[:id])
    @work = Work.new(
      title: session[:title],
      medium: session[:medium],
      source: session[:source],
      author: session[:author],
      release_date: Date.parse(session[:release_date_1i]+"-"+session[:release_date_2i]+"-"+session[:release_date_3i]),
      synopsis: session[:synopsis],
      )

    if session[:image_cache_name]
      @image_url = session[:image_url]
      @image_cache_name = session[:image_cache_name]
    end

    @actors = session[:actors]
    @genres = session[:genres]

  end

  def update
    @work = Work.find(session[:id])

    @before_actors = @work.actor_mngs.pluck(:actor_id)
    @before_genres = @work.genre_mngs.pluck(:genre_id)

    if session[:image_cache_name]
      @work.update(work_params.merge(image: params[:cache][:image]))
    else
      @work.update(work_params)
    end

    # 作品と出演者の中間テーブルの作成&削除
    ActorMng.where(work_id: @work.id).delete_all
      session[:actors].each do|actor|
        @actor_mng = ActorMng.new(
          work_id: @work.id,
          actor_id: actor
          )
        @actor_mng.save
      end

     # 作品とジャンルの中間テーブルの作成
    GenreMng.where(work_id: @work.id).delete_all
    session[:genres].each do|genre|
      @genre_mng = GenreMng.new(
        work_id: @work.id,
        genre_id: genre
        )
      @genre_mng.save
    end

      # sessin を全て空にする
      session.delete(:title)
      session.delete(:medium)
      session.delete(:source)
      session.delete(:author)
      session.delete(:release_date)
      session.delete(:synopsis)
      session.delete(:image_url)
      session.delete(:image_cache_name)
      session.delete(:actors)
      session.delete(:genres)
      session.delete(:id)

      redirect_to admin_work_path(@work.id)
  end

     private

  def work_params
    params.require(:work).permit(:id, :image, :image_cache, :remove_image, :image_cache, :title, :medium, :synopsis, :source, :author, :release_date, :actor, :genre, :is_deleted, :is_deleted_all,:is_search)
  end

  def actor_set_q
    @q = Actor.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end

  def genre_set_q
    @q = Genre.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end

  def work_set_q
    @q = Work.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
    @works = @q.result(distinct: true)
  end

end
