require "mechanize"
require "book"

def scrapeInfo(bookArr, page, link,  i = 0)
	bookArr[i] = Book.new
	table = page.css(".bibItems");
	bookArr[i].getTableInfo(table);

	bookDetails = page.css(".bibDetail")[0]
	bookArr[i].getAuthor(bookDetails, bookArr[i]);

	bookArr[i].uri = link
	
	#Fix this in book
	####bookArr[i].transform_values! { |k| k.gsub(/\n/, "") }
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
puts

#Submits the user query to the search bar on the page
page = agent.submit(searchInput);

#Looks for a specific CSS node identifying whether or not
#the query resulted in a book or link page
checkBookOrList = page.css(".save")

bookArr = []

if !checkBookOrList.empty? # Book page
	bookLink = page.link.uri
	scrapeInfo(bookArr, page, bookLink)
	puts bookArr[0]
elsif page.css("h2")[2].text == "NO ENTRIES FOUND" # No search results.
	puts "Page is empty."
else # List page
	# Array to hold book hashes.
	puts "List page."

	#Creates a CSS array of every node with a title
	results = page.css(".briefcitTitle")

	i = 0
	until i == 5
		bookPath = results.css('a')[i]["href"]
		bookLink = "https://library.ohio-state.edu" + bookPath
		nextPage = agent.get(bookLink)
		
		scrapeInfo(bookArr, nextPage, bookLink, i)
		pp bookArr[i]
		i += 1
	end

end

puts
printResults(bookArr)
puts #Empty line separator
puts "Finished!"

