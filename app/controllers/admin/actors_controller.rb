class Admin::ActorsController < ApplicationController
    before_action :set_q, only: [:index]

  def index
    @actor = Actor.new
    @actors = Actor.all
  end

  def create
    @actor = Actor.new(actor_params)
    @actor.save
    flash[:notice] ="新しい出演者が登録されました."
    redirect_to admin_actors_path
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
