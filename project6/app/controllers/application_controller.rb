class ApplicationController < ActionController::Base
    include SessionsHelper
    include CoursesHelper
    include GraderApplicationsHelper
end
