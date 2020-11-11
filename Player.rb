require_relative 'Deck'
require_relative 'Hand'

class Player

  attr_reader :name
  attr_reader :isBot
  attr_reader :hand

  def initialize(name, isBot)
    @name = name
    @isBot = isBot
    @hand = Hand.new
  end

  def numCards
    return @hand.length
  end

  def insertCard
  end

end

player = Player.new("player", false)
