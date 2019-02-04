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
puts "In order to enter a set, you must press the enter key. You will then be prompted to enter your name, and then the number of each card in the set."
puts # Print a new line
puts "Press Enter when you are ready to begin."
gets
puts # Print a new line

d = Deck.new
d.shuffle
t = Table.new(d)

t.setExist(d)

t.printTable	# Will probably need to put in a loop at some point so that
		# each round starts with printing the table.



puts # Print a new line
puts "Press enter when you find a set!"
gets
puts # Print a new line
puts "Enter your name:"
name = gets.chomp
puts # Print a new line
puts "Enter the cards in the set:"
setGuess = gets.chomp
set = setGuess.scan(/\d+/)
set = set.map { |card| card.to_i }
cardSet = t.getCardSet(set)
isSet = t.isSet?(cardSet)
if (isSet)
	puts "Congratulations! You've found a set."
	scoreHash[name] += 1
	puts "#{scoreHash[name]}"
	t.removeCardSet(set)
	t.add3Cards(d)
	t.printTable
else
	puts "This is not a set. Please try again."
end
