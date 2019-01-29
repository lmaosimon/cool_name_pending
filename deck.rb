require "./card.rb"

class Deck

	# Think about algorithm for figuring out if a table has a set on it.
	# Also think about an algorithm for checking if three selected cards make up a set.

	def initialize
		@deck = []

		i = 0

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

	def deck
		@deck
	end

	def shuffle
		@deck.shuffle!
	end

	def pop
		@deck.pop
	end

end
