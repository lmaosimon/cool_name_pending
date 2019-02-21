# Author: Gino Detore 

=begin

Class: Book
The Book class is designed to keep track of the various pieces of information for each book found in the results of a web query. For our case, each Book will have its own title, author, location, status, web uri attributes. As a collection, this information tells the user everything they need to know about each result of their query.

=end
class Book
	
	# Creates getter and setter methods
	attr_accessor :title, :author, :location, :status, :uri


=begin

The getTableInfo instance method is given a html table from an individual book page and 
gets the location and status of the book using the given css selector. This is done
using the Nokigiri css method which returns a node set.

=end
def getTableInfo(table)
	entries = table.css(".bibItemsEntry td")
	@location = entries[0].text
	@status = entries[3].text
end


=begin

The getAuthor instance method is given table "bookDetails" to set the author and title of 
the book. Since a book may not have an author (such as a video or WebBook) so we check
if the label of the first table entry has the text of "Author".

=end
def getAuthor(bookDetails)
	if (bookDetails.css(".bibInfoLabel")[0].text == "Author")
		@author = bookDetails.css(".bibInfoData")[0].text
		@title = bookDetails.css(".bibInfoData")[1].text
	else
		@author = "No author."
		@title = bookDetails.css(".bibInfoData")[0].text
	end
end


=begin

The instance method Transform values removes the newline characters from the instance
variables of the book.

=end
def transformValues
	@title.gsub!(/\n/, "")
	@author.gsub!(/\n/, "")
	@location.gsub!(/\n/, "")
	@status.gsub!(/\n/, "")
end

end
