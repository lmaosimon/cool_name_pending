require "./deck.rb"
require "./card.rb"

class Table

	@@colorH = { 0 => "Red",
	    	1 => "Green",
		2 => "Blue" }

	@@shadingH = { 0 => "Solid",
	    	1 => "Striped",
		2 => "Empty" }

	@@shapeH = { 0 => "Squiggle",
	    	1 => "Oval",
		2 => "Diamond" }

	@@numberH = { 0 => "One",
	    	1 => "Two",
		2 => "Three" }
	
	def initialize(deck)
		@table = []
		
		for i in 0..11
			@table[i] = deck.pop
		end
	end

	def printTable

		printf("       %-7s  %-9s  %-10s  %-8s\n", "COLOR:", "SHADING:", "SHAPE:", "NUMBER:")

		for i in 0..11
			printf("%2d.    %-7s  %-9s  %-10s  %-8s\n", (i + 1), @@colorH[@table[i].color], @@shadingH[@table[i].shading], @@shapeH[@table[i].shape], @@numberH[@table[i].number])
		end

	end

end



