class AdminController < ApplicationController
  before_action :require_signin
  before_action :require_admin

  def index
    @genres = Genre.all
  end

  def to_param
  end
end
