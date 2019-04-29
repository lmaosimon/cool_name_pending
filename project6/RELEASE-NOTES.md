# RELEASE NOTES

## Changes we've made for v2.0

* Added a status to the Courses index and admin_index views. This status appears for every course
  in the list, and first appears as 'Open'. Once a student is assigned to a course by the admin,
  the status of the course they were assigned to will change to their name and email so that the
  teacher can contact the student.
* Once a user has been assigned to a by the admin course, we got rid of the assignment button
  on the All Applications page available to the admin. This prevents the admin from reaccessing
  the assign page after they have already assigned a student. We did this to prevent any unexpected
  application behavior if the admin accidentally changed an assignment.
* Once a student is assigned a course, we made a change so that the course is now out of consideration
  for students submitting applications, and out of consideration for the admin to assign a user 
  to that course who had already submitted an application for that course.
* We got rid of a couple redundant script lines in the _teacher_header.html.erb file that were causing
  errors in the log.
* Added restrictions on general student and teacher users so that they cannot access admin only pages.
* Added the restriction that only non-logged in users can access the home page so that logged in users
  can't access it and log in/sign up again, causing unwanted behavior.