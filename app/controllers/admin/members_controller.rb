class Admin::MembersController < ApplicationController
  before_action :set_q, only: [:index]
  
  def index
    @members = Member.all
    @members = Member.page(params[:page])
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice]="変更内容を保存しました"
      redirect_to admin_member_path(id: @member.id)
    else
      render "edit"
    end
  end
  
  def destroy
    @member = Member.find(params[:id])
    @member.destroy
    redirect_to admin_members_path
  end

       private

  def member_params
    params.require(:member).permit(:name, :email, :is_deleted)
  end
  
  def set_q
    @q = Member.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end

end
