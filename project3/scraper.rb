require "mechanize"
require "mail"
require "./book.rb"

# Authors: Patrick Hubbell, Gino Detore, and Sean Bower

# ******** METHODS ********

=begin

The sendEmail method uses the mail gem.
We figured out how to use this gem from the gem source itself on GitHub.
Source: https://github.com/mikel/mail

This method sends all the search results with links to the user.

Parameters: Given a string of all the search result info that we want to send in the email.

Output: An email to the email address that the user inputs.

NOTE: We had a couple instances where the receival of the email was not instantaneous, it took  ~2 to 3 minutes.
Every other test took about 30 seconds to a minute to receive an email.

=end
def sendEmail(bodyStr)

	puts
	print "Input an email address to send your search results to: "
	userEmail = gets.chomp
	puts

	# Loop to make sure a valid email address is given by the user
	until userEmail =~ /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ # Regexp to check email string
		puts "An invalid email was inputted."
		puts "Input an email address to send your search results to: "
		userEmail = gets.chomp
		puts
	end

	# These are the options necessary for sending an email to the user
	options = { :address              => "smtp.gmail.com",
	    	    :port                 => 587,
	    	    :user_name            => 'osulibfor3901@gmail.com',
	    	    :password             => 'GoBucks!',
	    	    :authentication       => 'plain',
	    	    :enable_starttls_auto => true  }

	Mail.defaults do
		delivery_method :smtp, options
	end

	# Block that sends the email with all the search information
	Mail.deliver do
		to userEmail
		from 'osulibfor3901@gmail.com'
		subject 'OSU Library Search Results'
		body bodyStr
		content_type 'text/plain; charset=UTF-8'
	end
end

=begin

getBooksStr concatenates all search information into one string to be send as the body
of the email to the user.

Parameters: Given an array of Book objects.
	    Given a string of the link for the search results page.

Output: Returns a string with all the search information concatenated.

=end
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

=begin

scrapeInfo method accesses the table on each separate search result item page which contains
information on status and availability of the item. It then retrieves the information and
stores it in the instance variables of the book object that is created and
inserted in the book array at the beginning of the method.

Parameters: Given a book array which contains book objects for each search result item.
	    Given a Mechanize page which is the webpage of the current item.
	    Given a link, which is the link of the current item webpage.
	    Given an index for where the new Book object should be inserted in the book array.

Output: The book array has a new Book object with new instance variable values inserted into it.

=end
def scrapeInfo(bookArr, page, link,  i = 0)
	bookArr[i] = Book.new

	# Get info from details table on item webpage.
	table = page.css(".bibItems");
	bookArr[i].getTableInfo(table);

	# Get info on author and title of the book on item webpage.
	bookDetails = page.css(".bibDetail")[0]
	bookArr[i].getAuthor(bookDetails);

	# Set the uri instance variable of the book object to the link string
	bookArr[i].uri = link
	
	# Get rid of new lines in info scraped from the item webpage.
	bookArr[i].transformValues
end

# ******** BEGINNING OF SCRAPER CODE ********

# The URL for the OSU library website that we will use
url = "https://library.osu.edu"

# Boolean which will cause the program to loop if user's search has no search results
searchAgain = true

puts
puts "Welcome to the OSU Library Website!"

# Loop to have the user input another search if there are no search results
while searchAgain

	# Initialize a new Mechanize object
	agent = Mechanize.new

	# Get the webpage of the OSU Library
	page = agent.get(url)

	# Get the "Books and More" button
	button = page.link_with(id: 'searchBooksLink');

	# Click on the "Books and More" button to be able to make searches in the OSU library catalogue
	page = button.click

	# Retrieve the search form where the user inputs a search query
	forms = page.forms
	searchInput = forms[1];

	# Get search query from user
	puts
	puts "Input a keyword, author, title, subject, or number that you want to search for."
	searchInput.q = gets.chomp
	puts

	#Submits the user query to the search bar on the page
	page = agent.submit(searchInput);
	pageURI = page.link.resolved_uri.to_s

	#Looks for a specific CSS node identifying whether or not
	#the query resulted in a single book result page or list results  page
	checkBookOrList = page.css(".save")

	# Initializes the array that will hold Book objects for each search result
	bookArr = []

	# Retrieve string on result page which tells us if there were search results or not
	emptyResultCheck = page.css("h2")[2].text

	# If-elsif-else conditionals to scrape info based on if a single item is found,
	# or if a list of items is found. If no items are found, then the program will
	# loop and ask the user for a new search query.
	if !checkBookOrList.empty? # Scrapes the info for a page with a single item result
		puts "Loading your search results..."
		bookLink = page.link.resolved_uri.to_s
		scrapeInfo(bookArr, page, bookLink)
		searchAgain = false # Set to false so program does not loop and ask for another search query
	# No search results
	elsif emptyResultCheck == "NO ENTRIES FOUND" || emptyResultCheck == "You must enter data to search by."
		puts "Page is empty. No search results found."
	else # Scrapes the info for a list results page

		#Creates a Nokogiri NodeSet of every node with a title
		results = page.css(".briefcitTitle")
	
		puts "Loading your search results..."

		i = 0
		until i == results.length

			# Get the link for the current item webpage
			bookPath = results.css('a')[i]["href"]
			bookLink = "https://library.ohio-state.edu" + bookPath
			nextPage = agent.get(bookLink)

			# Let the user know that results have been found
			if i % 5 == 0 && i != 0
				puts "Loaded #{i} results..."
			end

			# Get info for a separate search result
			scrapeInfo(bookArr, nextPage, bookLink, i)
			i += 1
		end

		# Tell the user how many results were found
		puts "Successfully loaded #{i} results."
		searchAgain = false # Set to false so program does not loop and ask for another search query
	end
end

#Ensures that some results were found from the user's query before sending
if bookArr.length != 0 

	#Gets a string containing info for all books from search result
	allBooks = getBooksStr(bookArr, pageURI)

	#Sends an email containing the query results to the user
	sendEmail(allBooks);

	puts "An email has been sent to your account with the search results."
end

puts "Goodbye!"
