require "mechanize"

def scrapeInfo(bookArr, page, i = 0)
	bookArr[i] = Hash.new
	table = page.css(".bibItems");
	bookArr[i] = getTableInfo(table);
	bookDetails = page.css(".bibDetail")[0]
	getAuthor(bookDetails, bookArr[i]);
	bookArr[i].transform_values! { |k| k.gsub(/\n/, "") }
end

def getTableInfo(table)
	bookHash = Hash.new
	entries = table.css(".bibItemsEntry td")
	bookHash["location"] = entries[0].text
	bookHash["status"] = entries[3].text
	return bookHash
end

def getAuthor(bookDetails, bookHash)
	if (bookDetails.css(".bibInfoLabel")[0].text == "Author")
		puts "Author is there."
		bookHash["author"] =  bookDetails.css(".bibInfoData")[0].text
		bookHash["title"] =  bookDetails.css(".bibInfoData")[1].text
	else
		puts "Author is not there."
		bookHash["title"] =  bookDetails.css(".bibInfoData")[0].text
	end
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
puts

#pp searchInput

page = agent.submit(searchInput);
bookArr = []

checkBookOrList = page.css(".save")

if !checkBookOrList.empty? # Book page
	scrapeInfo(bookArr, page)
	puts bookArr[0]
elsif page.css("h2")[2].text == "NO ENTRIES FOUND" # No search results.
	puts "Page is empty."
else # List page
	# Array to hold book hashes.
	puts "List page."
	bookArr = []
	results = page.css(".briefcitTitle")

	i = 0
	until i == 5
		bookPath = results.css('a')[i]["href"]
		bookLink = "https://library.ohio-state.edu" + bookPath
		nextPage = agent.get(bookLink)
		scrapeInfo(bookArr, nextPage, i)
		pp bookArr[i]
		i += 1
	end

end


