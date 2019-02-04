require "./deck.rb"
require "./card.rb"

# Authors: Patrick Hubbell, Sean Bower, Gino Detore

=begin

Class: Table
The purpose of the Table class is to create a table of 12 cards by taking them out of the deck. These will be the 12 cards that players try to make a set from. This class also has instance methods for printing the table for the players to see, going through all combinations of 3 cards on the table until a set is found, determining if 3 given cards are a set, and adding 3 cards to the table if no sets exist on the table.

=end

class Table
	
	# The values of each card state correspond to a specific card attribute.
	# Here we use hashes to keep track of what attribute needs to be printed in the table
	# depending on what the value of each state is.
	@@colorH = { 0 => "Red",
	    	1 => "Green",
		2 => "Blue" }

	@@shadingH = { 0 => "Solid",
	    	1 => "Dotted",
		2 => "Empty" }

	@@shapeH = { 0 => "Star",
	    	1 => "Oval",
		2 => "Triangle" }

	@@numberH = { 0 => "One",
	    	1 => "Two",
		2 => "Three" }
	
=begin

The initialize instance method is given a deck object as a parameter.
It initializes a table instance variable to hold the 12+ cards that the players will try to make a set from.

=end
	def initialize(deck)
		@table = []
		
		for i in 0..11
			@table[i] = deck.pop
		end
	end

=begin

The printTable instance method takes no parameters as input.
It prints out the current cards on the table so players can try to find a set.

=end
	def printTable

		printf("       %-7s  %-9s  %-10s  %-8s\n", "COLOR:", "SHADING:", "SHAPE:", "NUMBER:")

		for i in 0...@table.length
			printf("%2d.    %-7s  %-9s  %-10s  %-8s\n", (i + 1), @@colorH[@table[i].color], @@shadingH[@table[i].shading], @@shapeH[@table[i].shape], @@numberH[@table[i].number])
		end

	end

=begin

The isSet? instance method is given an array of 3 cards as a parameter.
It calculates whether or not 3 cards make up a set.
Returns true if the 3 cards make up a set, false otherwise.
How calculation works: Since each state of each card holds a value of 0, 1, or 2, we know that if all values are the same for a specific state, (e.g. all 3 cards have value of 1,2, or 3 for color), then the sum of these values is divisible by 3. Likewise, if all values are different for a specific state, (e.g. Card 1 has value 0 for color, card 2 has value 1, and card 2 has value 2), then the sum of these values is also divisible by 3. Thus, we sum each state for all three cards and do % 3 to determine if all sums are divisible by 3. If a result does not equal 0, then we know that the three cards do not make up a set.

=end
	def isSet?(set)
		isSet = false
		if ((set[0].color + set[1].color + set[2].color) % 3 == 0 && (set[0].shading + set[1].shading + set[2].shading) % 3 == 0 && (set[0].shape + set[1].shape + set[2].shape) % 3 == 0 && (set[0].number + set[1].number + set[2].number) % 3 == 0)
			isSet = true
		end
		return isSet
	end

=begin

The findSet? instance method takes no parameters as input.
It iterates through every possible combination of 3 cards, and each combination is put in its own array which is given in a call to isSet? to calculate whether or not the cards make up a set.
Returns true if a set is found, false otherwise.

=end
	def findSet?
		found = false
		set = []
		
		# Nested while loops used to iterate through each card combination.
		i = 0
		while i < @table.length
			set[0] = @table[i]
			# Setting j = i + 1 to make sure a duplicate combination is not tested
			j = i + 1 
			while j < @table.length
				set[1] = @table[j]
				# Setting k = j + 1 to make sure a duplicate combination is nt tested
				k = j + 1
				while k < @table.length
					set[2] = @table[k]
					if self.isSet?(set) # Pass set of 3 cards to isSet?
 						# If true, set is found so return true
						return true
					end
					k += 1
				end
				j += 1
			end
			i += 1
		end

		return false # Set has not been found so return false
	end
		
	def setExist?(deck)
		while self.findSet? == false
			for i in 0..2
				@table[@table.length] = deck.pop
			end
		end
	end

end



