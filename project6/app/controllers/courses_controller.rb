class CoursesController < ApplicationController
  # Make sure only a logged in user with status of Employee can have access to these actions
  before_action :logged_in_teacher, only: [:new, :index, :create, :destroy, :edit, :update]
  # Make sure the current user doesn't have access to another teacher's pages/actions
  before_action :correct_user, only: [:new, :index, :create, :destroy, :edit, :update]
  # Make sure only an admin can view the admin view of all the courses submitted
  before_action :admin_user, only: [:admin_index]
  
  # Controller action for an employee user to view the create a new course page
  def new
    # Create a new course
    @course = Course.new;
  end

  # Controller action for an employee user to view all of the courses they have submitted
  def index
    # Get an array of this employee's courses
    @courses = current_user.courses;
  end

  # Controller action for an admin to view all courses submitted by all employees
  def admin_index
    # Get an array of all employee's courses
    @courses = Course.all;
  end

  # Controller action for an employee to create a new course for a student to apply to
  def create
    # Create a new course with strong parameters via course_params private method
    @course = Course.new(course_params);
    if @course.save
      flash[:success] = "Course successfully added to list of courses!"
      current_user.courses << @course;
      redirect_to courses_url;
    else
      render 'new'
    end
  end

  # Controller action to destroy a course that has been created
  def destroy
    Course.find(params[:id]).destroy;
    flash[:success] = "Course deleted";
    redirect_to courses_url;
  end

  # Controller action to view the form of an already submitted course to be edited
  def edit
    @course = Course.find(params[:id]);
    # Stops one teacher from updating another teacher's courses
    if (@course.user_id != current_user.id && !current_user.admin?)
      redirect_to current_user;
      flash[:danger] = "You are not authorized to access another teacher's courses."
    end
  end

  # Controller action to update an edited course
  def update
    @course = Course.find(params[:id]);
    if (@course.update_attributes(course_params))
      flash[:success] = "Course updated";
      if (current_user.admin?)
        redirect_to allcourses_url;
      else
        redirect_to courses_url;
      end
    else
      render 'edit'
    end
  end

  private

    # To prevent unwanted/malicious data being passed to Course.new when a new course is being created,
    # this strong parameters function is used to specify which which parameters are required and
    # which ones are permitted
    def course_params
      params.require(:course).permit(:instructor, :email, :course_name, :section, :monday, :tuesday,
        :wednesday, :thursday, :friday, :start_time, :end_time);
    end

    # Function to check if current user is logged in as an Employee, else redirect to the login page
    def logged_in_teacher
      unless logged_in? && isTeacher?(current_user)
        if (isStudent?(current_user))
          flash[:danger] = "Students are not authorized to access this page.";
          redirect_to current_user;
        else
          flash[:danger] = "You must be logged in as a teacher to view this page."
          redirect_to login_url;
        end
      end
    end

    # Function to check if the correct user is accessing a page corresponding to their user
    # account. If they try to access a page belonging to another user, they are redirected to
    # their own profile page
    def correct_user
      redirect_to(current_user) unless current_user?(current_user);
    end

    # Function to check if the user attempting to access an admin only page is an admin. If they
    # are not an admin, they are redirected to their own profile page
    def admin_user
      redirect_to(current_user) unless current_user.admin?;
    end
end
