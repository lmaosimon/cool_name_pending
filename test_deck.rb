require "./deck.rb"
require "./card.rb"

d = Deck.new

classType1 = d.class
puts "#{classType1}"
classType2 = d.deck[0].class
puts "#{classType2}"

for i in [0..11]
	c = d.deck[i]
	puts "#{c.color}"
end

d.shuffle

for i in [0..11]
	c = d.deck[i]
	puts "#{c.color}"
end
