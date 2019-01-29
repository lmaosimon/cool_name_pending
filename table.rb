require "./deck.rb"
require "./card.rb"

class Table

	colorH = { 	0 => "Red",
	    		1 => "Green",
			2 => "Purple" }

	shadingH = { 	0 => "Solid",
	    		1 => "Striped",
			2 => "Empty" }

	shapeH = { 	0 => "Squiggle",
	    		1 => "Oval",
			2 => "Diamond" }

	numberH = { 	0 => "One",
	    		1 => "Two",
			2 => "Three" }
	
	def initialize(deck)
		@table = []
		
		for i in 0..11
			@table[i] = deck.pop
		end
	end

	def printTable

		puts "#{colorH[@table[0].color]}"

	end

end



