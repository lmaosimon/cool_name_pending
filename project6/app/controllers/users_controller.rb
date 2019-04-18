class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show]
  before_action :correct_user, only: [:show]
  def new
    @user = User.new;
  end

  def show
    @user = User.find(params[:id]);
  end

  def create
    @user = User.new(user_params);
    if @user.save
      log_in(@user);
      flash[:success] = "Welcome to the OSU CSE Grader's Portal!"
      redirect_to @user;
    else
      render 'new'
    end
  end

  def update
    if (params[:password].blank?)
      params.delete(:password);
    end
    @user = User.find(params[:id]);
    if (@user.update_attributes(user_params))
      flash[:success] = "User assigned to course";
      @user.grader_application.assignment = course_info(@user.course);
      @user.grader_application.save;
      redirect_to allapplications_url;
    else
      flash[:danger] = "User could not be assigned to course"
      redirect_to allapplications_url;
    end
  end

  private
    def user_params
      params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :status, :course_id);
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in.";
        redirect_to login_url
      end
    end

    def correct_user
      if (User.exists?(params[:id]))
        @user = User.find(params[:id]);
        redirect_to(current_user) unless @user == current_user;
      else
        redirect_to(current_user);
      end
    end
end           
