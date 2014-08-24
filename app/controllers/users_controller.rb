class UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    unless current_user.is_admin?
      begin
        redirect_to :back, :alert => "You are not authorized to access this page."
      rescue
        redirect_to root_url, :alert => "You are not authorized to access this page."
      end
    end
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

end
