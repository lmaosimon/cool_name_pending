require "./card.rb"

# Author: Patrick Hubbell

=begin

Class: Deck
The purpose of the Deck class is to create a deck of 81 card objects, and give each of the four states of each card object a value from 0 to 2. Each card will have a unique combination of of state values so that every card is different. This class also contains methods for getting the deck, shuffling the deck, and taking a card out from the deck.

=end
class Deck

=begin

The initialize instance method takes no parameters as input.
Creates an instance variable @deck, which holds an array of all 81 unique cards.

=end
	def initialize
		@deck = []

		i = 0
		
		# Four nested for loops used to make each unique card in the deck.
		for color in 0..2
			for shape in 0..2
				for shading in 0..2
					for number in 0..2
						@deck[i] = Card.new
						@deck[i].color = color
						@deck[i].shape = shape
						@deck[i].shading = shading
						@deck[i].number = number
						i += 1
					end
				end
			end
		end
	end

=begin

The deck instance method takes no parameters as input.
It is a getter method that returns the deck upon call.

=end
	def deck
		@deck
	end

=begin

The shuffle instance method takes no parameters as input.
It updates the deck by randomly shuffling it.

=end
	def shuffle
		@deck.shuffle!
	end

=begin

The pop instance method takes no parameters as input.
It takes the last card from the deck and returns it to the caller.

=end
	def pop
		@deck.pop
	end

	def size
		@deck.length
	end

end
