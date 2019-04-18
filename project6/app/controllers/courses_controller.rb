class CoursesController < ApplicationController
  before_action :logged_in_teacher, only: [:new, :index, :create, :destroy, :edit, :update ]
  before_action :correct_user, only: [:new, :index, :create, :destroy, :edit, :update ]
  def new
    @course = Course.new;
  end

  def index
    @courses = current_user.courses;
  end

  def admin_index
    @courses = Course.all;
  end

  def create
    @course = Course.new(course_params);
    if @course.save
      flash[:success] = "Course successfully added to list of courses!"
      current_user.courses << @course;
      redirect_to courses_url;
    else
      render 'new'
    end
  end

  def destroy
    Course.find(params[:id]).destroy;
    flash[:success] = "Course deleted";
    redirect_to courses_url;
  end

  def edit
    @course = Course.find(params[:id]);
    # Stops one teacher from updating another teacher's courses
    if (@course.user_id != current_user.id && !current_user.admin?)
      redirect_to current_user;
      flash[:danger] = "You are not authorized to access another teacher's courses."
    end
  end

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
    def course_params
      params.require(:course).permit(:instructor, :email, :course_name, :section, :monday, :tuesday,
        :wednesday, :thursday, :friday, :start_time, :end_time);
    end

    def logged_in_teacher
      unless logged_in? && isTeacher?(current_user)
        if (isStudent?(current_user))
          flash[:danger] = "Students are not authorized to access this page.";
          redirect_to current_user;
        else
          flash[:danger] = "You must be logged in as a teacher to view this page."
          redirect_to login_url
        end
      end
    end

    def correct_user
      redirect_to(current_user) unless current_user?(current_user)
    end
end
