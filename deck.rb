class Deck

	def initialize
		@deck = []
	end

	def shuffle
		@deck.shuffle
	end

	def dealCard
		return @deck.pop
	end

end
