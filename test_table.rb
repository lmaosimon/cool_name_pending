require "./table.rb"
require "./deck.rb"
require "./card.rb"

d = Deck.new
d.shuffle
t = Table.new(d)

t.printTable

found = t.findSet?

puts "#{found}"

if !found

	t.setExist?(d)
	found = t.findSet?
	puts "#{found}"
end

t.printTable

