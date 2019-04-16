class GraderApplicationsController < ApplicationController
  before_action :logged_in_student, only: [:new, :index, :create, :destroy, :edit, :update ]
  before_action :correct_user, only: [:new, :index, :create, :destroy, :edit, :update ]
  
  def new
    @applications = GraderApplication.new
  end

  def index
    @applications = GraderApplication.all
  end

  def create
    @application = GraderApplication.new(application_params);
    if @application.save
      flash[:success] = "Application successfully submitted!"
      current_user.grader_application << @application;
      redirect_to current_user; #FIXME:
    else
      render 'new'
    end
  end

  def destroy

  end

  def edit

  end

  def update

  end

  private
    def application_params
      params.require(:grader_application).permit(:name, :email, :qualifications, course_ids:[]);
    end

    def logged_in_student
      unless logged_in? && isStudent?(current_user)
        if (!isStudent?(current_user))
          flash[:danger] = "Only students may apply for grader positions.";
          redirect_to current_user;
        else
          flash[:danger] = "You must be logged in as a student to view this page."
          redirect_to login_url
        end
      end
    end

    def correct_user
      redirect_to(current_user) unless current_user?(current_user)
    end

end
