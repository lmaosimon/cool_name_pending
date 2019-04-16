class CoursesController < ApplicationController
  def new
    @course = Course.new;
  end

  def index
    @courses = current_user.courses;
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
  end

  def update
    @course = Course.find(params[:id]);
    if (@course.update_attributes(course_params))
      flash[:success] = "Course updated";
      redirect_to courses_url;
    else
      render 'edit'
    end
  end

  private
    def course_params
      params.require(:course).permit(:instructor, :email, :course_name, :section, :monday, :tuesday,
        :wednesday, :thursday, :friday, :start_time, :end_time);
    end
end
