class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :show, :edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.paginate page: params[:page]
  end

  def show
    @user = User.find params[:id]
    @courses = current_user.courses
  end

  def create
    @user = User.new user_params
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Framgia Training Management System - tms_11!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find params[:id]
  end

  def update
    @user = User.find params[:id]
    if @user.update_attributes user_params
      flash[:success] = "Profile updated!"
      redirect_to @user
      log_update_profile
    else
      render 'edit'
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in!"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find params[:id]
    if !current_user?(@user)
      store_location
      flash[:danger] = "You do not have permission to edit
                        the other user's profile!"
      redirect_to users_path
    end
  end

  def log_update_profile
    act = current_user.activities.new act_type: "update profile"
    act.save
  end
end