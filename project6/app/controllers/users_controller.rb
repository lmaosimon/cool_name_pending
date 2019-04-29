class UsersController < ApplicationController
  # Only allow a logged in user/the correct user to view their profile page
  before_action :logged_in_user, only: [:show]
  before_action :correct_user, only: [:show]

  # Controller action for the log in page
  def new
    # Create a new user
    @user = User.new;
  end

  # Controller action for the user's profile page
  def show
    # Get the correct user via user id in params hash
    @user = User.find(params[:id]);
  end

  # Controller action for the sign up page
  def create
    # Create a new user with strong parameters via user_params private method
    @user = User.new(user_params);
    if @user.save
      # Log user into their session via log_in function in sessions_helper.rb
      log_in(@user);
      flash[:success] = "Welcome to the OSU CSE Grader's Portal!"
      redirect_to @user;
    else
      render 'new'
    end
  end

  # Controller action to update user attributes
  # This action only occurs when the admin assigns a course to a student user
  def update

    # Delete password attribute from hash so update_attributes function below
    # does not attempt to update the password, leads to errors otherwise.
    if (params[:password].blank?)
      params.delete(:password);
    end

    # Find the student user whose assignment attribute is changing
    @user = User.find(params[:id]);

    # Update their attributes
    if (@user.update_attributes(user_params))
      flash[:success] = "User assigned to course";
      # Give the student their assignment
      @user.grader_application.assignment = course_info(@user.course);
      @user.grader_application.save;
      # Set the assigned attribute of the course they were assigned to to true
      c = Course.find(@user.course_id);
      c.assigned = true;
      c.save;
      redirect_to allapplications_url;
    else
      flash[:danger] = "User could not be assigned to course"
      redirect_to allapplications_url;
    end
  end

  private

    # To prevent unwanted/malicious data being passed to User.new when a new user is being created,
    # this strong parameters function is used to specify which which parameters are required and
    # which ones are permitted
    def user_params
      params.require(:user).permit(:id, :name, :email, :password, :password_confirmation, :status, :course_id);
    end

    # Function to check if current user is logged in, else redirect to the login page
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in.";
        redirect_to login_url
      end
    end

    # Function to check if the correct user is accessing a page corresponding to their user
    # account. If they try to access a page belonging to another user, they are redirected to
    # their own profile page
    def correct_user
      if (User.exists?(params[:id]))
        @user = User.find(params[:id]);
        redirect_to(current_user) unless @user == current_user;
      else
        redirect_to(current_user);
      end
    end
end           
