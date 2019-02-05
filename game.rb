require "./card.rb"
require "./deck.rb"
require "./table.rb"

# Authors: Patrick Hubbell, Gino Detore, and Sean Bower

puts  # Print a line
puts "Hello! This is The Game of Set!"
puts "How many players are there?"
playerCount = gets.chomp.to_i	# Get number of players and convert to an integer
puts  # Print a line

# Initialize a hash where the keys are the player names and the values are their scores
scoreHash = Hash.new
playerNames = []  # An array to hold player names

# A while loop to initialize each player score to 0 in the hash
i = 0
while i < playerCount
	puts "What is the name of player #{(i + 1)}?"
	playerNames[i] = gets.chomp
	scoreHash[playerNames[i]] = 0
	i += 1
end
puts  # Print a line

# Print directions for the users
puts "Directions for entering a set during the game:"
puts "In order to enter a set, you must press the enter key. You will then be prompted to enter your name, and then the number of each card in the set, separated by numbers and commas (E.g. 1, 2, 3)."
puts # Print a line
puts "Press Enter when you are ready to begin."
gets # Get Enter input from user

d = Deck.new 	  # Initialize a new deck of cards
d.shuffle 	  # Shuffle the deck
t = Table.new(d)  # Initialize a table of 12 cards, giving the deck as a parameter
finished = false  # Boolean to help determine if game is finished

while !finished	 # While loop that iterates through each round of the game

	# Boolean to help determine if users need to guess a new set if incorrect set is inputted
	retryGuess = true

	while retryGuess  # Will loop if a user guesses an incorrect set

		# Function that checks if a set is on the table, continually adds 3 cards if not
		t.setExist(d)

		t.printTable  # Print the current table of cards
		puts 	      # Print a line

		print "Press Enter when you find a set!\n(For a hint, type \"hint #\", where # is a number from 1-3 which specifies how many cards of a set you want revealed) "
		input = gets.chomp  # Get Enter or hint input from user
		
		# If the user requests a hint, call provideHint Table instance method to get a hint string
		if (input.include?("hint"))
			# Note: We currently have provideHint written to give 2 cards of a set
			puts("The cards {" + t.provideHint(input[input.size - 1].to_i) + "} are a subset of a valid set")
			puts
			print "Press Enter when you find a set!"
			gets
		end

		puts  # Print a line
		print "Enter your name: "
		name = gets.chomp  # Get player name from user
	
		# While loop checks if user input is a valid player name. If not, user must input again.
		while !scoreHash.has_key?(name)
			puts "Player #{name} does not exist."
			puts  # Print a line
			print "Enter your name: "
			name = gets.chomp  # Get player name from user
		end

		puts  # Print a line
		print "Enter the cards in the set: "
		setGuess = gets.chomp  # Get users guess for a set in the table

=begin
 Use regexp /\d+/ to get each digit or sequence of 2 digits in between the commas and spaces.
 Use scan String method to make an array of these 1 or 2 digit strings.
=end
		set = setGuess.scan(/\d+/)   

		offTable = 0 # Integer to keep track of how many card numbers the user inputted that are not valid

		# Use block arg to go through each set element and determine if card number is valid
		set.each { |x| if x.to_i < 1 || x.to_i > t.size then offTable += 1 end}
		while offTable > 0  # If offTable > 0, then user inputted an invalid card number
			puts "#{offTable} of these cards is/are not on the table. Please try again."
			puts # Print a line
			print "Enter the cards in the set: "
			setGuess = gets.chomp  # Get users guess for a set in the table
                	set = setGuess.scan(/\d+/)  # Make a new array of integer strings
			offTable = 0
			# Once again, check for invalid card number inputs
			set.each { |x| if x.to_i < 1 || x.to_i > t.size then offTable += 1 end}
		end
		
		set = set.map { |card| card.to_i } # Convert each string in set to an integer

		# Make a set of the actual card objects corresponding to the card numbers that were inputted
		cardSet = t.getCardSet(set)
		isSet = t.isSet?(cardSet)  # Check if the card set is an actual set
		if isSet  # If true, increment player score and add 3 more cards
			puts "Congratulations! You've found a set."
			scoreHash[name] += 1
			t.removeCardSet(set)
			if (d.size != 0)
				t.add3Cards(d)
			end
			retryGuess = false  # retryGuess is false because user made a correct guess
			puts # Print new line
		else  # If false, retryGuess is still true, so users have to try another guess
			puts "This is not a set. Please try again."
			puts  # Print a line
			puts "Press Enter to continue."
			gets  # Get Enter input from user
			puts  # Print a line
		end
	end

	# Print the current score of the game
	puts "Here is the current score:"
	for i in 0...playerCount
		printf "%s has %d\n", playerNames[i], scoreHash[playerNames[i]]
	end

	puts  # Print a line
	puts "Press Enter to continue."
	gets  # Get Enter input from user
	puts  # Print a line

	# If the deck is depleted and there are no more sets on the table, then the game is over
	if (d.size == 0 && t.findSet? == false)
		finished = true
		puts "Game over!"
		# Print the final score of the game
		puts "The final score is:"
		for i in 0...playerCount
			printf "%s has %d\n", playerNames[i], scoreHash[playerNames[i]]
		end
	end

end
