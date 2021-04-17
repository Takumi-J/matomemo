class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_q, only: [:index]

  def index
    @genre = Genre.new
    @genres = Genre.all
    @genres = Genre.page(params[:page])
  end

  def create
    @genre = Genre.new(genre_params)
    @genre.save
    flash[:notice] ="新しいジャンルが登録されました."
    redirect_to admin_genres_path
  end

  def destroy
    @genre = Genre.find(params[:id])
    @genre.destroy
    redirect_to admin_genres_path
  end

   private

  def genre_params
    params.require(:genre).permit(:id, :name)
  end

  def set_q
    @q = Genre.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end

end
