require "mechanize"
require "book"


def printResults(bookArray)
	puts
	puts "Here are your search results:"

	i = 0
	until i = bookArray.length
		book = bookArray[i]
		puts
		puts "Title: " + book["title"]
		puts "Author: " + book["author"]
		puts "Location: " + book["location"]
		puts "Status: " + book["status"]
		puts "URL: " + book["url"]
		puts i
		i += 1
	end
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

#pp searchInput

page = agent.submit(searchInput);

checkBookOrList = page.css(".save")

bookArr = []

if !checkBookOrList.empty? # Book page
	bookArr[0] = Book.new
	table = page.css(".bibItems");
	bookHash = getTableInfo(table);
	bookDetails = page.css(".bibDetail")[0]
	getAuthor(bookDetails, bookHash);
	#bookPath = results.css('a')[i]["href"]
	#bookLink = "https://library.ohio-state.edu" + 
	#puts bookHash
	bookHash.transform_values! { |k| k.gsub(/\n/, "") }
	#puts bookHash
elsif page.css("h2")[2].text == "NO ENTRIES FOUND" # No search results.
	puts "Page is empty."
else # List page
	# Array to hold book hashes.
	puts "List page."

	results = page.css(".briefcitTitle")

	i = 0
	until i == 5
		bookPath = results.css('a')[i]["href"]
		bookLink = "https://library.ohio-state.edu" + bookPath
		nextPage = agent.get(bookLink)
		bookArr[i] = Hash.new
		bookArr[i]["url"] = bookLink

		table = page.css(".bibItems");
		bookArr[i] = getTableInfo(table);
		bookDetails = nextPage.css(".bibDetail")[0]
		getAuthor(bookDetails, bookArr[i]);
		bookArr[i].transform_values! { |k| k.gsub(/\n/, "") }
		pp bookArr[i]
		i += 1
	end

end

puts
printResults(bookArr)
puts #Empty line separator
puts "Finished!"
