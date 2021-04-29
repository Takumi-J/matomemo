class Admin::ActorsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_q, only: [:index]

  def index
    @actor = Actor.new
    @actors = Actor.all
    @actors = Actor.page(params[:page])
  end

  def create
    @actor = Actor.new(actor_params)
    if !Actor.exists?(name: @actor.name)
      @actor.save
      flash[:notice] ="新しい出演者が登録されました！"
      redirect_to admin_actors_path
    else
      flash[:notice] ="既にに登録済みです。"
      redirect_to admin_actors_path
    end
  end

  def destroy
    @actor = Actor.find(params[:id])
    @actor.destroy
    redirect_to admin_actors_path
  end

   private

  def actor_params
    params.require(:actor).permit(:id, :name)
  end

  def set_q
    @q = Actor.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end

end
