require 'test_helper'

class GraderApplicationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get grader_applications_new_url
    assert_response :success
  end

end
