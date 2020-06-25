# frozen_string_literal: true

class ApplicationController < ActionController::Base
  add_flash_types(:danger)

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def require_signin
    redirect_to signin_path, alert: 'Please sign in first' unless current_user
  end

  def intended_url
    session[:intended_url] = request.url
  end

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def current_user_admin?
    current_user&.admin?
  end

  helper_method :current_user_admin?

  def require_admin
    redirect_to movies_url, alert: 'Not authorized!' unless current_user_admin?
  end

  def goto_root_if_urlerror
    @model_name = self.class.name.sub('Controller', '').singularize.classify.constantize
    redirect_to('/') if @model_name.find_by(id: params[:id]).nil?
  end
end
