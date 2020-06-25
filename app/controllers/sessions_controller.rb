class SessionsController < ApplicationController
	def new
	end

	def create
	#fail
		user = User.find_by(email: params[:email_or_username]) || User.find_by(username: params[:email_or_username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			uri = session[:intended_url]
			session[:intended_url] = nil
			redirect_to (uri || user), notice: "Welcome back, #{user.name}!"
			
		else
			flash.now[:alert] = "Atsa no good"
			render :new
		end

	end

	# def create
	# 	user = User.find_by(email: params[:email])
	# 	if user && user.authenticate(params[:password])
	# 		session[:user_id] = user.id
	# 		redirect_to (session[:intended_url] || user), notice: "Welcome back, #{user.name}"
	# 		session[:intended_url] = nil
	# 	else
	# 		flash.now[:alert] = "Invalid email/password combination!"
	# 		render :new
	# 	end
	# end

	def destroy
		session[:user_id] = nil
		redirect_to movies_path, alert: "You have logged out."
	end
end
