class Admin::ActorMngsController < ApplicationController
  before_action :authenticate_admin!
  def create
    @actor = Actor.find(params[:actor_id])
    @work_actor = ActorMng.new(actor_mng_params)
  end
end
