class ReviewsController < ApplicationController
	before_action :intended_url
	before_action :set_movie
	before_action :require_signin, except: [:index]

	def index
		
		@reviews = @movie.reviews
		
	end

	def new
	
		@review = @movie.reviews.new

	end

	def destroy
	 
		@review = @movie.reviews.find(params[:id])
		@review.delete
		redirect_to @movie
	end

	def edit
		
		@review = @movie.reviews.find(params[:id])
	end

	def update
		   
		@review = @movie.reviews.find(params[:id])
		@params = get_params
		if @review.update(@params)
			redirect_to @movie
		else
			render :edit
		end
	end
 
	def create
		
		@review = @movie.reviews.new(get_params)
		@review.user = current_user

		if @review.save
			redirect_to movie_reviews_path(@movie), notice: "Thanks for your review"
		else
			render :new
		end
	end
	private
	def get_params
		params.require(:review).permit(:stars, :comment)
	end

	def set_movie
		@movie = Movie.find_by!(slug: params[:movie_id])
	end
end
