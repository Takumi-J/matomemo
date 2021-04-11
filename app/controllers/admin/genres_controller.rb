class Admin::GenresController < ApplicationController
  before_action :set_q, only: [:index]

  def index
    @genre = Genre.new
    @genres = Genre.all
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
    #pamas = {
    #  'q' => {
    #    'name_cont' => ''
    #  }
    #}
    # params[:q][:name_cont] # => ''
    # params[:q] # true, {}, '', [], 1, 2
    # false, nil
    @q = Genre.ransack(params[:q])
    @results = []
    if params[:q]
      @results = @q.result
    end
  end

end
