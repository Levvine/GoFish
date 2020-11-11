require_relative 'Card'

class Deck

  def initialize

    @deck = [] # actual deck of cards not currently in a hand

    suits = Card.suits.length
    values = Card.values.length - 1

    Card.suits.each do |i|
      Card.values.each do |j|
        if j
          #puts "j:#{j} Card.values.length:#{Card.values.length}"
          @deck.append Card.new(i, j)
        end
      end
    end

    # @cardList = @deck.clone # list of all cards containing obj refs

  end

  def size
    return @deck.length
  end

  def shuffle
    @deck.shuffle!
  end

  def sort_bySuit
    Card.sort_bySuit(@deck)
  end

  def sort_byValue
    Card.sort_byValue(@deck)
  end

  def deal(player, num)
    added = []
    while num > 0
      added += player.hand.add(@deck.shift)
      num -= 1
    end
    return added
  end

end

#deck = Deck.new
#deck.shuffle
#p deck
