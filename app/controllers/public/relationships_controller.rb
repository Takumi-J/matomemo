class Public::RelationshipsController < ApplicationController
  before_action :set_member

  def create
    following = current_member.follow(@member)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      redirect_to others_path(others_id: @member.id)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'

    end
  end

  def destroy
    following = current_member.unfollow(@member)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
      redirect_to others_path(others_id: @member.id)
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_to others_path(others_id: @member.id)
    end
  end

  private

  def set_member
    @member = Member.find params[:follow_id]
  end

end
