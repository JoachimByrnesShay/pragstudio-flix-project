# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :intended_url
  before_action :require_signin, except: %i[index show]
  before_action :require_admin, except: %i[index show]
  before_action :set_movie, only: %i[show edit update destroy]
  #before_action :goto_root_if_urlerror, only: %i[show edit]


  def index
        @movies = Movie.send(movies_filter)
  end

  def show
   
   # goto_root_if_urlerror
    @review = @movie.reviews.new
    @fans = @movie.fans
    @genres = @movie.genres
    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit
  
  end

  def update
    
    if @movie.update(get_movie_params)
      # flash[:notice] = "Movie successfully updated!"
      # redirect_to movie_path(@movie)
      redirect_to @movie, notice: 'Movie successfully updated!'
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(get_movie_params)
    if @movie.save
      redirect_to @movie, notice: 'Movie successfully created!'
    else
      render :new
    end
  end

  def destroy
     
    @movie.delete
    redirect_to movies_url, alert: 'Movie deleted!'
  end

  def movies_filter
    if %w(upcoming recent hits flops).index(params[:filter])
      #params[:filter].in? %w(upcoming recent hits flops)
      params[:filter]
    else
      :released
    end
  end


  private



  def set_movie
      @movie = Movie.find_by!(slug: params[:id])
  end
  def get_movie_params
    params.require(:movie)
          .permit(:title, :description, :rating, :released_on, :total_gross, :director, :duration, :image_file_name, genre_ids: [])
  end
end
