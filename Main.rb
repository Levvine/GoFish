require_relative 'Deck'
require_relative 'GoFish'
require_relative 'Player'

deck = Deck.new
player = Player.new
cpu1 = Player.new
game = GoFish.new(deck, player, cpu1)
game.start
