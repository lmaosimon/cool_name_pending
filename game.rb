require "./card.rb"
require "./deck.rb"
require "./table.rb"

puts # Print a new line
puts "Hello! This is The Game of Set!"
puts "How many players are there?"
playerCount = gets.chomp.to_i
puts # Print a new line

scoreHash = Hash.new
playerNames = []
i = 0
while i < playerCount
	puts "What is the name of player #{(i + 1)}?"
	playerNames[i] = gets.chomp
	scoreHash[playerNames[i]] = 0
	i += 1
end
puts # Print a new line

puts "Directions for entering a set during the game:"
puts "In order to enter a set, you must press the enter key. You will then be prompted to enter your name, and then the number of each card in the set, separated by numbers and commas (E.g. 1, 2, 3)."
puts # Print a new line
puts "Press Enter when you are ready to begin."
gets
puts # Print a new line

d = Deck.new
d.shuffle
t = Table.new(d)
finished = false

while !finished
	t.setExist(d)

	t.printTable	

	puts # Print a new line
	puts "Press Enter when you find a set!"
	gets
	puts # Print a new line
	print "Enter your name: "
	name = gets.chomp
	
	while !scoreHash.has_key?(name)
		puts "Player #{name} does not exist."
		puts
		print "Enter your name: "
		name = gets.chomp
	end

	puts # Print a new line
	print "Enter the cards in the set: "

	correctGuess = false;
	while !correctGuess
		setGuess = gets.chomp
		set = setGuess.scan(/\d+/)

		offTable = 0
		set.each { |x| if x.to_i < 1 || x.to_i > t.size then offTable += 1 end}
		while offTable > 0
			puts "#{offTable} of these cards is not on the table. Please try again."
			puts
			print "Enter the cards in the set: "
			setGuess = gets.chomp
                	set = setGuess.scan(/\d+/)
			offTable = 0
			set.each { |x| if x.to_i < 1 || x.to_i > t.size then offTable += 1 end}
		end
		
		set = set.map { |card| card.to_i }
		cardSet = t.getCardSet(set)
		isSet = t.isSet?(cardSet)
		if (isSet)
			puts "Congratulations! You've found a set."
			correctGuess = true
			scoreHash[name] += 1
			t.removeCardSet(set)
			t.add3Cards(d)
			puts # Print a new line
		else
			puts "This is not a set. Please try again."
			puts # Print a new line
			print "Enter the cards in the set: "
		end
	end

	puts "Here is the current score:"
	for i in 0...playerCount
		printf "%s has %d\n", playerNames[i], scoreHash[playerNames[i]]
	end
	puts # Print a new line
	puts "Press enter to continue."
	gets
	puts # Print a new line

end
