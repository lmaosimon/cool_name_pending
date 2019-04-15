class CoursesController < ApplicationController
  def new
    @course = Course.new;
  end

  def create
    @course = Course.new(course_params);
    if @course.save
      flash[:success] = "Course successfully added to list of courses!"
      current_user.courses << @course;
      redirect_to current_user;
    else
      render 'new'
    end
  end

  private
    def course_params
      params.require(:course).permit(:instructor, :email, :course_name, :section, :monday, :tuesday,
        :wednesday, :thursday, :friday, :start_time, :end_time);
    end
end
