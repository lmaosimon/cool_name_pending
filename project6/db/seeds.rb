# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "Gino Detore", email: "detore.4@osu.edu", status: "Student", password: "foobar", password_confirmation: "foobar");
User.create(name: "Patrick Hubbell", email: "hubbell.64@osu.edu", status: "Student", password: "foobar", password_confirmation: "foobar");
User.create(name: "Sean Bower", email: "bower.205@osu.edu", status: "Student", password: "foobar", password_confirmation: "foobar");
User.create(name: "Scott Sharkey", email: "sharkey.30@osu.edu", status: "Employee", password: "foobar", password_confirmation: "foobar", admin: true);
User.create(name: "Diego Zaccai", email: "zaccai.1@osu.edu", status: "Employee", password: "foobar", password_confirmation: "foobar");
User.create(name: "Michael Fritz", email: "fritz.26@osu.edu", status: "Employee", password: "foobar", password_confirmation: "foobar");
User.create(name: "Michael Green", email: "green.25@osu.edu", status: "Employee", password: "foobar", password_confirmation: "foobar");
User.create(name: "Janis Jones", email: "jones.5684@osu.edu", status: "Employee", password: "foobar", password_confirmation: "foobar");

Course.create(course_name: "CSE 2431", instructor: "Janis Jones", email: "jones.5684@osu.edu", section: "21111", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, start_time: "12:00 PM", end_time: "12:55 PM", user_id: 8);

Course.create(course_name: "CSE 3901", instructor: "Scott Sharkey", email: "sharkey.30@osu.edu", section: "11111", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, start_time: "3:00 PM", end_time: "4:20 PM", user_id: 4);

Course.create(course_name: "CSE 3901", instructor: "Scott Sharkey", email: "sharkey.30@osu.edu", section: "33151", monday: false, tuesday: true, wednesday: false, thursday: true, friday: false, start_time: "6:00 PM", end_time: "7:20 PM", user_id: 4);

Course.create(course_name: "CSE 2421", instructor: "Michael Green", email: "green.25@osu.edu", section: "31111", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, start_time: "9:30 AM", end_time: "10:55 AM", user_id: 7);

Course.create(course_name: "CSE 2421", instructor: "Michael Green", email: "green.25@osu.edu", section: "32222", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, start_time: "12:30 PM", end_time: "1:55 PM", user_id: 7);

Course.create(course_name: "CSE 2421", instructor: "Michael Green", email: "green.25@osu.edu", section: "33333", monday: false, tuesday: true, wednesday: false, thursday: true, friday: false, start_time: "10:00 AM", end_time: "11:40 AM", user_id: 7);

Course.create(course_name: "CSE 2321", instructor: "Michael Fritz", email: "fritz.26@osu.edu", section: "41111", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, start_time: "9:10 PM", end_time: "10:05 PM", user_id: 6);

Course.create(course_name: "CSE 2321", instructor: "Michael Fritz", email: "fritz.26@osu.edu", section: "42222", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, start_time: "11:00 PM", end_time: "11:55 PM", user_id: 6);

Course.create(course_name: "CSE 2321", instructor: "Michael Fritz", email: "fritz.26@osu.edu", section: "43333", monday: false, tuesday: true, wednesday: false, thursday: true, friday: false, start_time: "9:00 AM", end_time: "10:20 AM", user_id: 6);

Course.create(course_name: "CSE 2321", instructor: "Michael Fritz", email: "fritz.26@osu.edu", section: "44444", monday: false, tuesday: true, wednesday: false, thursday: true, friday: false, start_time: "1:00 PM", end_time: "1:20 PM", user_id: 6);

Course.create(course_name: "CSE 2331", instructor: "Diego Zaccai", email: "zaccai.1@osu.edu", section: "51111", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, start_time: "9:00 AM", end_time: "9:55 AM", user_id: 5);

Course.create(course_name: "CSE 2331", instructor: "Diego Zaccai", email: "zaccai.1@osu.edu", section: "52222", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, start_time: "11:00 AM", end_time: "11:55 AM", user_id: 5);

Course.create(course_name: "CSE 2331", instructor: "Diego Zaccai", email: "zaccai.1@osu.edu", section: "53333", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, start_time: "1:00 PM", end_time: "1:55 PM", user_id: 5);

Course.create(course_name: "CSE 2331", instructor: "Diego Zaccai", email: "zaccai.1@osu.edu", section: "54444", monday: false, tuesday: true, wednesday: false, thursday: true, friday: false, start_time: "10:20 AM", end_time: "11:40 AM", user_id: 5);

Course.create(course_name: "CSE 2331", instructor: "Diego Zaccai", email: "zaccai.1@osu.edu", section: "55555", monday: false, tuesday: true, wednesday: false, thursday: true, friday: false, start_time: "1:20 PM", end_time: "2:40 PM", user_id: 5);

Recommendation.create(name: "Patrick Hubbell", email: "hubbell.64@osu.edu", course: "CSE 3901", section: "33151", user_id: 4);

Recommendation.create(name: "Sean Bower", email: "bower.205@osu.edu", course: "CSE 2421", section: "33333", user_id: 7);

Recommendation.create(name: "Gino Detore", email: "detore.4@osu.edu", course: "CSE 2321", section: "41111", user_id: 6);