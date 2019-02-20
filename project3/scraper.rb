require "mechanize"

def getTableInfo(table)
	bookHash = Hash.new
	entries = table.css(".bibItemsEntry td")
	bookHash["location"] = entries[0].text
	bookHash["status"] = entries[3].text
	return bookHash
end


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

#pp searchInput

page = agent.submit(searchInput);

test = page.css(".save").text
test2 = page.css("a")
#puts test2.class

if !test.empty?
	bookHash = Hash.new
	puts "You're on a book page!"
	table = page.css(".bibItems");
	bookHash = getTableInfo(table);
elsif
	puts "You're on a list page!"
	a = [] #Array to hold book hashes.
end

#searchLinks = page.links

results = page.css(".briefcitTitle")

i = 0
until i == 5
	bookPath = results.css('a')[i]["href"]
	bookLink = "https://library.ohio-state.edu" + bookPath
	nextPage = agent.get(bookLink)
	
	
	i += 1
end
