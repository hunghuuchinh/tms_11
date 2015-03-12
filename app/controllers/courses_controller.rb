class CoursesController < ApplicationController
  before_action :logged_in_user

  def index
    @user = User.find params[:user_id]
    @courses = @user.courses
  end

  def show
    @user = User.find params[:user_id]
    @course = Course.find params[:id]
  end  

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in!"
      redirect_to login_url
    end
  end
end