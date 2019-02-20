# Author: Gino Detore 

=begin

Class: Book
The Book class is designed to keep track of the various pieces of information for each book found in the results of a web query. For our case, each Book will have its own title, author, location, status, web uri attributes. As a collection, this information tells the user everything they need to know about each result of their query.

=end
class Book
	
	# Creates getter and setter methods
	attr_accessor :title, :author, :location, :status. :uri

end


=begin



=end
def getTableInfo(table)
	entries = table.css(".bibItemsEntry td")
	@location = entries[0].text
	@status = entries[3].text
end


=begin



=end
def getAuthor(bookDetails)
	if (bookDetails.css(".bibInfoLabel")[0].text == "Author")
		@author =  bookDetails.css(".bibInfoData")[0].text
		@title =  bookDetails.css(".bibInfoData")[1].text
	else
		@author = "No author."
		@title =  bookDetails.css(".bibInfoData")[0].text
	end
end

