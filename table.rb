require "./deck.rb"
require "./card.rb"

class Table

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

	def isSet?(set)
		isSet = false
		puts "#{set[0].color} #{set[0].shading} #{set[0].shape} #{set[0].number}    #{set[1].color} #{set[1].shading} #{set[1].shape} #{set[1].number}    #{set[2].color} #{set[2].shading} #{set[2].shape} #{set[2].number}"
		if ((set[0].color + set[1].color + set[2].color) % 3 == 0 && (set[0].shading + set[1].shading + set[2].shading) % 3 == 0 && (set[0].shape + set[1].shape + set[2].shape) % 3 == 0 && (set[0].number + set[1].number + set[2].number) % 3 == 0)
			isSet = true
			puts "Is true"
		end
		return isSet
	end

	def findSet?
		found = false
		set = []

		i = @table.length - 1
		while i >= 0
			set[0] = @table[i]
			j = i - 1
			while j >= 0
				set[1] = @table[j]
				k = j - 1
				while k >= 0
					set[2] = @table[k]
					if self.isSet?(set)
						found = true
					end
					k -= 1
				end
				j -= 1
			end
			i -= 1
		end
=begin
		size = @table.length
		for i in 0..11
			set[0] = @table[i]
			for j in (i + 1)..11
				set[1] = @table[j]
				for k in (j + 1)..11
					set[2] = @table[k]
					if (isSet?(set))
					    found = true
					end
				end
			end
		end
=end
		return found
	end

end



