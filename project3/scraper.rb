require "mechanize"

url = "https://library.osu.edu"

agent = Mechanize.new
page = agent.get(url)

button = page.link_with(id: 'searchBooksLink');

page = button.click

forms = page.forms
searchInput = forms[1];

puts
puts "Welcome to the OSU Library Website!"
puts "Input a keyword, author, title, subject, or number that you want to search for."
searchInput.q = gets.chomp

pp searchInput

page = agent.submit(searchInput);

test = page.css(".save").text

if test != ""
	puts "You're on a book page!"
elsif
	puts "You're on a list page!"
end

searchLinks = page.links

