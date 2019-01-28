require "./deck.rb"

d = Deck.new

classType1 = d.class
puts "#{classType1}"
classType2 = d.deck[0].class
puts "#{classType2}"

for i in [0..11]
	puts "#{d.deck[i].color}"
end

d.shuffle

for i in [0..11]
	puts "#{d.deck[i].color}"
end
