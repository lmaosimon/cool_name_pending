require "mechanize"
require "mail"
require "./book.rb"

def sendEmail(bodyStr)

	puts
	print "Input an email address to send your search results to: "
	userEmail = gets.chomp
	puts

	until userEmail =~ /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/
		puts "An invalid email was inputted."
		puts "Input an email address to send your search results to: "
		userEmail = gets.chomp
		puts
	end

	options = { :address              => "smtp.gmail.com",
	    	    :port                 => 587,
	    	    :user_name            => 'osulibfor3901@gmail.com',
	    	    :password             => 'GoBucks!',
	    	    :authentication       => 'plain',
	    	    :enable_starttls_auto => true  }

	Mail.defaults do
		delivery_method :smtp, options
	end

	Mail.deliver do
		to userEmail
		from 'osulibfor3901@gmail.com'
		subject 'OSU Library Search Results'
		body bodyStr
		content_type 'text/plain; charset=UTF-8'
	end
end

def getBooksStr(bookArr, pageLink)
	bookStr = ""
	i = 0
	until i == bookArr.length
		bookStr = bookStr + "Title: " + bookArr[i].title + "\n"
		bookStr = bookStr + "Author: " + bookArr[i].author + "\n"
		bookStr = bookStr + "Location: " + bookArr[i].location + "\n"
		bookStr = bookStr + "Status: " + bookArr[i].status + "\n"
		bookStr = bookStr + "URI: " + bookArr[i].uri + "\n\n"
		i += 1
	end
	bookStr = bookStr + "Link to results page: " + pageLink + "\n"
	return bookStr
end

def scrapeInfo(bookArr, page, link,  i = 0)
	bookArr[i] = Book.new
	table = page.css(".bibItems");
	bookArr[i].getTableInfo(table);

	bookDetails = page.css(".bibDetail")[0]
	bookArr[i].getAuthor(bookDetails);

	bookArr[i].uri = link
	
	bookArr[i].transformValues
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
pageURI = page.link.resolved_uri.to_s

#Looks for a specific CSS node identifying whether or not
#the query resulted in a book or link page
checkBookOrList = page.css(".save")

bookArr = []

if !checkBookOrList.empty? # Book page
	bookLink = page.link.uri
	scrapeInfo(bookArr, page, bookLink)
	puts bookArr[0]
elsif page.css("h2")[2].text == "NO ENTRIES FOUND" # No search results.
	puts "Page is empty. No search results found."
else # List page

	#Creates a CSS array of every node with a title
	results = page.css(".briefcitTitle")
	
	puts "Loading your search results..."

	i = 0
	until i == 10 || i == results.length
		bookPath = results.css('a')[i]["href"]
		bookLink = "https://library.ohio-state.edu" + bookPath
		nextPage = agent.get(bookLink)
		
		scrapeInfo(bookArr, nextPage, bookLink, i)
		#pp bookArr[i].title
		i += 1
	end
end

if bookArr.length != 0 
	#Gets a string containing info for all books from search result
	allBooks = getBooksStr(bookArr, pageURI)

	#Sends an email containing the query results to the user
	sendEmail(allBooks);

	puts "An email has been sent to your account with the search results."
end

puts "Goodbye!"
