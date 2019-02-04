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

t.printTable	# Will probably need to put in a loop at some point so that
		# each round starts with printing the table.


