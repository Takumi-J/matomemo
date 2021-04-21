class Admin::ActorMngsController < ApplicationController
  def create
    @actor = Actor.find(params[:actor_id])
    @work_actor = ActorMng.new(actor_mng_params)
    # @work_actor.actor_id の設定
    # @work_actor.work_id の設定
  end
end
