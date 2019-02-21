OSU Library Online Catalogue Search Results Scraper

	The purpose of this program is to allow a user to search for a book title,
	keyword, author, book number, etc. on the OSU Library Online Catalogue.
	If their search has multiple results (greater than 1) then the scraper
	scrapes information on 50 results by accessing each result link
	and retrieving the title, author, location of the item, 
	availability, and URI of the page. If there are less than 50 results, the program
	will scrape as many results as there are on the result page. If there is only
	one result, then the website redirects the user directly to the result page
	of the single item and the item information is retrieved. If no items are found, 
	the user is notified and the program finishes. Once all information is scraped,
	the user inputs their email and an email of all the search results is sent 
	to them. The program is then finished.

Getting Started

	In order to run the program:

		Make sure you are in the project directly and enter the command: bundle install

		This will allow you to install all the necesessary gems for the program to run as expected.

	To run the program:

		Enter the command: ruby ./scraper.rb

	Expected inputs while running the program:

		You will be expected to enter a search for the library catalogue to get your results.
		We did searches such as:
			fish (A single keyword to generate many results)
			diwaodwahdiwaojd (Random letters that result in no search results)
			Breed predispositions to disease in dogs and cats / Alex Gough, Alison Thomas, Dan O'Neill (A book title that leads directly to a book page)

		You will also be expected to enter a valid email address to send your search results to.

Authors

	Patrick Hubbell, Gino Detore, and Sean Bower
			
Test Cases

	Test Case 1 for Catalogue Search:

		Input: "" (an empty string)

		Expected Output: Empty input not accepted, user prompted for new input search

		Actual Outputs: User prompted for new input search

		Test Successful

	Test Case 2 for Catalogue Search:

		Input: a;sldkfjghfjdksla;

		Expected Output: No entries found in search result, no email

		Actual Output: No entries found in search result, no email

		Test Successful

	Test Case 3 for Catalogue Search:

		Input: Do you have my favorite book?

		Expected Output: Email with 9 search results

		Actual Output: Email with 9 search results

		Test Successful

	Test Case 4 for Catalogue Search:

		Input: Easy Money

		Expected Output: Email with 50 search results

		Actual Output: Email with 50 search results

		Test Successful

	Test Case 1 for Email:

		Input: bower.205osu.edu

		Expected Output: An invalid email was inputted (Prompt user again)

		Actual Output: An invalid email was inputted (Prompt user again)

		Test Successful

	Test Case 2 for Email:

		Input: bower205@osuedu

		Expected Output: An invalid email was inputted (Prompt user again)

		Actual Output: An invalid email was inputted (Prompt user again)

		Test Successful

	Test Case 3 for Email:

		Input: bower205osuedu

		Expected Output: An invalid email was inputted (Prompt user again)

		Actual Output: An invalid email was inputted (Prompt user again)

		Test Successful

	Test Case 4 for Email:

		Input: bower.205@osuedu

		Expected Output: An invalid email was inputted (Prompt user again)

		Actual Output: An invalid email was inputted (Prompt user again)

		Test Successful

