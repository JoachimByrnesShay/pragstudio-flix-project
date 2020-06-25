class FavoritesController < ApplicationController
  before_action :require_signin
  before_action :set_movie

  def create
    #fail
    current_user.favorites.create!(movie: @movie)
    redirect_to @movie
  end

  def destroy
    @favorite = current_user.favorites.find_by(id: params[:id])
    @favorite.delete
    redirect_to @movie
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end
end
