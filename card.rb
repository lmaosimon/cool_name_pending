# Author: Patrick Hubbell

=begin

Class: Card
Upon initializing an object from this class with Card.new, there are four statesthat each card keeps track of. These are color, shape, shading, and number. By using attr_accessor to initialize all states, which are the symbols separated by commas, getter and setter methods are automatically created for each state.

=end
class Card

	attr_accessor :color, :shape, :shading, :number # Creates getter and setter methods

end
