class Admin::AssignmentsController < ApplicationController
  before_action :logged_in_user
  before_action :is_admin_user
  before_action :set_course
  before_action :assignable_course, only: [:new]

  def new
    @assignment = @course.assignments.new
    @users = User.assignable(@course)
  end

  def index
    @users = @course.users
  end

  private
  def set_course
    @course = Course.find params[:course_id]
  end

  def assignable_course
    @course = Course.find params[:course_id]
    if !@course.end_at.nil?
      flash[:danger] = "Course is finished! Cannot assign member"
      redirect_to admin_course_path(@course)
    elsif !@course.begin_at.nil?
      flash[:danger] = "Course is in training progress! Cannot assign member"
      redirect_to admin_course_path(@course)
    end
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in!"
      redirect_to login_url
    end
  end

  def is_admin_user
    redirect_to root_url unless admin_user?
  end
end