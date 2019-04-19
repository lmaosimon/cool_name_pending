# README

# OSU CSE Grader's Portal

# How to get the application up and running:

* Navigate into the project6 folder.
* Enter the command 'bundle update'.
* Enter the command 'bundle install --without production' to install all gems necessary for the
  development environment of the application.
* Enter the command 'rails db:migrate' to make sure the schema is up to date.
* Enter the command 'rails db:reset' to clear any possible lingering resources in the sqlite database
  and re-seed it with content from the seed file.
* Enter the command 'rails server' to be able to host the application.
* Open Firefox and enter '0.0.0.0:3000' in the website search bar to use the application.

# Student User Actions

* If you sign up or log in as an OSU student, you will be able to submit an grader application and
  select the course(s) you want to grade for among the courses that have been submitted by teachers.
* After submitting the application, you can edit or delete.
* If an admin assigns a course to you, the status of the grader application will change from
  pending to the course info of the course you have been assigned to.

# Teacher User Actions

* Teachers have the ability to submit applications for courses that they need graders for. These
  are the courses that the graders can choose to apply to. If a grader is assigned to a teacher's
  course by an admin, then the status of the teachers course application will change to the contact
  information of the user.
* Teachers can also submit recommendations for students to grade courses to help the admin make their
  decisions.

# Admin User Actions

* The admin has the ability to view all submitted student grader applications, all submitted courses
  by teachers, and all submitted recommendations by teachers.
* The admin can use the applications and recommendations to make their decision in what students they
  want to assign to courses. The admin assigns students to courses through the 'All Applications' page.

# Test Cases and Comments

* We began the project by writing test cases while developing, but quickly found that only being a
  group of 3, we did not have the proper amount of time to write all of the test cases, so we plan to
  add those in version 2 of the app.
* Likewise, being a group of 3, we struggled to have enough time to be able to comment our code when we
  finished version 1 of the app, so we plan to add comments in version 2 of the app.

# Authors

* Patrick Hubbell, Gino Detore, and Sean Bower

