class GraderApplicationsController < ApplicationController
  before_action :logged_in_student, only: [:new, :show, :create, :destroy, :edit, :update ]
  before_action :correct_user, only: [:new, :show, :create, :destroy, :edit, :update ]
  # Make sure only an admin can view the admin view of all the courses submitted
  before_action :admin_user, only: [:index]
  
  def new
    @application = GraderApplication.new
  end

  def show
    @application = GraderApplication.find(current_user.grader_application.id);
  end

  def index
    @applications = GraderApplication.all
  end

  def create
    @application = GraderApplication.new(application_params);
    if @application.save
      flash[:success] = "Application successfully submitted!"
      current_user.grader_application = @application;
      redirect_to current_user;
    else
      render 'new'
    end
  end

  def destroy
    GraderApplication.find(params[:id]).destroy;
    flash[:success] = "Application deleted";
    redirect_to current_user;
  end

  def edit
    @application = GraderApplication.find(current_user.grader_application.id);
    # Stops one student from editing another student's application
    if (@application.user_id != current_user.id && !current_user.admin?)
      redirect_to current_user;
      flash[:danger] = "You are not authorized to access another student's application."
    end
  end

  def update
    @application = GraderApplication.find(params[:id]);
    if (@application.update_attributes(application_params))
      flash[:success] = "Application updated";
      redirect_to current_user;
    else
      render 'edit'
    end
  end

  def assign
    @application = GraderApplication.find(params[:id]);
  end

  private
    def application_params
      params.require(:grader_application).permit(:name, :email, :qualifications, course_ids:[]);
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :status);
    end

    def logged_in_student
      unless logged_in? && isStudent?(current_user)
        if (!isStudent?(current_user) && !current_user.admin?)
          flash[:danger] = "Only students may apply for grader positions.";
          redirect_to current_user;
        elsif (current_user.admin?)
          render 'index'
        else
          flash[:danger] = "You must be logged in as a student to view this page."
          redirect_to login_url
        end
      end
    end

    def correct_user
      redirect_to(current_user) unless current_user?(current_user)
    end

    # Function to check if the user attempting to access an admin only page is an admin. If they
    # are not an admin, they are redirected to their own profile page
    def admin_user
      redirect_to(current_user) unless current_user.admin?;
    end

end
