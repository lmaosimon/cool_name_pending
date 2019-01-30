require "./table.rb"
require "./deck.rb"
require "./card.rb"

d = Deck.new
d.shuffle
t = Table.new(d)

t.printTable
