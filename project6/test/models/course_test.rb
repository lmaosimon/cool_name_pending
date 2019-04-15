require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  def setup
    @course = Course.new(course_name: "CSE 3901", instructor: "Scott Sharkey", email: "sharkey.30@osu.edu",
     section: "12345", start_time: "6:00 PM", end_time: "7:15 PM");
  end

  test "should be valid" do
    assert @course.valid?;
  end

  test "invalid time range should be invalid 1" do
    @course.end_time = "5:15 PM";
    assert_not @course.valid?;
  end

  test "invalid time range should be invalid 2" do
    @course.start_time = "8:00 AM";
    @course.end_time = "5:15 AM";
    assert_not @course.valid?;
  end

  test "invalid time range should be invalid 3" do
    @course.start_time = "5:15 PM";
    @course.end_time = "8:00 AM";
    assert_not @course.valid?;
  end

end
