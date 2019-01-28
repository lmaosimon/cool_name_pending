require "./deck.rb"

d = Deck.new

classType = d.class
puts "#{classType}"

for i in [0..11]
	puts "#{d.deck[i].color}"
end

d.shuffle

for i in [0..11]
	puts "#{d.deck[i].color}"
end
