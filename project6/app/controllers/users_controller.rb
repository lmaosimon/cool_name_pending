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

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :status);
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in.";
        redirect_to login_url
      end
    end

    def correct_user
      @user = User.find(params[:id]);
      redirect_to(current_user) unless @user == current_user;
    end
end           
