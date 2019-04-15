module CoursesHelper
    def course_days(course)
        daysStr = "";
        if(course.monday)
            daysStr = daysStr + "M";
        end
        if(course.tuesday)
            daysStr = daysStr + "T";
        end
        if(course.wednesday)
            daysStr = daysStr + "W";
        end
        if(course.thursday)
            daysStr = daysStr + "Tr";
        end
        if(course.friday)
            daysStr = daysStr + "F";
        end
        return daysStr;
    end
end
