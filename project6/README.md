# README

# OSU CSE Grader's Portal v2.0

* [Check out the release notes!](./RELEASE-NOTES.md)

## To view the alpha version of the application in the production environment:

* Visit: https://lit-lake-37158.herokuapp.com

## How to get the application up and running in development environment:

* Navigate into the project6 folder.
* Enter the command 'bundle update'.
* Enter the command 'bundle install --without production' to install all gems necessary for the
  development environment of the application.
* Enter the command 'rails db:migrate' to make sure the schema is up to date.
* Enter the command 'rails db:reset' to clear any possible lingering resources in the sqlite database    and re-seed it with content from the seed file.
* Enter the command 'rails server' to be able to host the application.
* Open Firefox and enter '0.0.0.0:3000' in the website search bar to use the application.

## Using our Application

* You can use our application as a student, teacher, or teacher/admin user.
* All users must sign up with a valid OSU name.number, and they must sign up with the correct
  student or teacher affiliation.
* If you want to test out a student or teacher view of the website, simply sign up with a valid OSU      email (An email of a real person affiliated with OSU) of a student or teacher. We also have some       users that have already been signed up via the seed file, so check out the seed file if you want to    log in as one of those users.
* If you want to test out the admin view of the website, we created an admin in the seed file that
  you can log in as. Simply log in with email: sharkey.30@osu.edu and password: foobar.

## Student User Actions

* If you sign up or log in as an OSU student, you will be able to submit an grader application and
  select the course(s) you want to grade for among the courses that have been submitted by teachers.
* After submitting the application, you can edit or delete.
* If an admin assigns a course to you, the status of the grader application will change from
  pending to the course info of the course you have been assigned to.

## Teacher User Actions

* Teachers have the ability to submit applications for courses that they need graders for. These
  are the courses that the graders can choose to apply to. If a grader is assigned to a teacher's
  course by an admin, then the status of the teachers course application will change to the contact
  information of the user.
* Teachers can also submit recommendations for students to grade courses to help the admin make their
  decisions.

## Admin User Actions

* The admin has the ability to view all submitted student grader applications, all submitted courses
  by teachers, and all submitted recommendations by teachers.
* The admin can use the applications and recommendations to make their decision in what students they
  want to assign to courses. The admin assigns students to courses through the 'All Applications' page.

## Authors

* Patrick Hubbell, Gino Detore, and Sean Bower

