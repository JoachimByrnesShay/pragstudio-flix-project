module MoviesHelper
	def total_gross(movie)
		if movie.flop?
			"Flop!"
		elsif movie.cult_classic?
			"Cult Classic!"
		else
			number_to_currency(movie.total_gross, precision: 0)
		end
	end

	def year_of(movie)
		movie.released_on.year
	end

  def fave_or_unfave_button(favorite, movie)
    if favorite
      button_to '* unfave', movie_favorite_path(movie, favorite), method: 'delete'
    else
      button_to '* fave', movie_favorites_path(movie)
    end
  end
end
