require "./table.rb"
require "./deck.rb"
require "./card.rb"

d = Deck.new
t = Table.new(d)

t.printTable
