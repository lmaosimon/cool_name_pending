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

	t.printTable	

	puts # Print a new line
	puts "Press Enter when you find a set! (type \"hint\" for a hint)"
	input = gets.chomp
	if (input == "hint")
		puts(t.provideHint(d))
	end
	puts # Print a new line
	print "Enter your name: "
	name = gets.chomp
	puts # Print a new line
	print "Enter the cards in the set: "

	correctGuess = false;
	while !correctGuess
		setGuess = gets.chomp
		set = setGuess.scan(/\d+/)
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
