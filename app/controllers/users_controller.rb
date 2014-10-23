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

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user.remove_all_roles if user_params[:role_ids].nil?
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: users_path }
      else
        format.html { render :edit }
        format.json { render json: users_path.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def notifcations
  end

  private
  def user_params
    params.require(:user).permit(:name, {:role_ids => []})
  end

end
