class RelationshipsController < ApplicationController
  before_action :set_member
  #redirect_to @memberの部分を指定のパスに変更する。
  #viewにおいてのフォローボタン、解除ボタンはまだ作っていないので、サイトを再度参照。

  def create
    following = current_member.follow(@member)
    if following.save
      flash[:success] = 'フォローしました'
      # redirect_to @member
    else
      flash.now[:alert] = 'フォローに失敗しました'
      # redirect_to @member
    end
  end

  def destroy
    following = current_member.unfollow(@member)
    if following.destroy
      flash[:success] = 'フォローを解除しました'
      # redirect_to @member
    else
      flash.now[:alert] = 'フォロー解除に失敗しました'
      # redirect_to @member
    end
  end
  
    private
  
   def set_member
    @member = Member.find(params[:follow_id])
   end
   
end
