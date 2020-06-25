class UsersController < ApplicationController

	#before_action :require_signin, only: [:index, :show, :edit, :update, :destroy]
	before_action :intended_url
	before_action :require_signin, except: [:new, :create]
	before_action :require_correct_user, only: [:edit, :update]
	#before_action :goto_root_if_urlerror, only: [:show, :edit]
	before_action :require_admin, only: [:destroy]
	before_action :set_user, only: %i(show create update destroy)

	def index
		@users = User.non_admins
	end

	def show
		#@user = User.find(params[:id])
		@reviews = @user.reviews
		@faves = @user.favorite_movies
	end

	def new
		@user = User.new
	end

	def create	 
    #fail
		#fail
		@user = User.new(user_params)
		if @user.save
			session[:user_id] = @user.id
			#fail
			redirect_to @user, notice: "Thanks for registering, #{@user.name}!"
		else 
			render :new
		end
	end

	def edit
	
	end

	def update
		if @user.update(user_params)
			redirect_to movies_url, notice: "Account has been updated"
		else
			render :edit
		end
	end

	def destroy
		#@user = User.find(params[:id])
		@user.destroy
		redirect_to movies_url, alert: "Account for #{@user.name} has been deleted"
	end

	private
	def user_params
		params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
	end

	def require_correct_user
		@user = User.find(params[:id])
		redirect_to root_url unless current_user?(@user)
	end
end

def set_user
  @user = User.find_by(username: params[:id])
end