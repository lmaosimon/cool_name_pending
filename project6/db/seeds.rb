# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(name: "Patrick Hubbell", email: "hubbell.64@osu.edu", status: "Student", password: "foobar", password_confirmation: "foobar");
User.create(name: "Gino Detore", email: "detore.4@osu.edu", status: "Student", password: "foobar", password_confirmation: "foobar");
User.create(name: "Scott Sharkey", email: "sharkey.30@osu.edu", status: "Employee", password: "foobar", password_confirmation: "foobar", admin: true);
User.create(name: "Jayson Boubin", email: "boubin.2@osu.edu", status: "Employee", password: "foobar", password_confirmation: "foobar");

Course.create(course_name: "CSE 3901", instructor: "Scott Sharkey", email: "sharkey.30@osu.edu", section: "11111", monday: true, tuesday: false, wednesday: true, thursday: false, friday: false, start_time: "3:00 PM", end_time: "4:00 PM");
Course.create(course_name: "CSE 2431", instructor: "Jayson Boubin", email: "boubin.2@osu.edu", section: "12345", monday: true, tuesday: false, wednesday: true, thursday: false, friday: true, start_time: "12:00 PM", end_time: "12:55 PM");