require_relative 'Card'

class Hand

  def initialize
    @cards = []
  end

  def getCards
    return @cards.clone
  end

  def empty
    return @cards.empty?
  end

  def add(*card)
    card.each { |c| @cards << c }
    return card
  end

  def remove(index)
    @cards.delete_at(index)
  end

  def find(suit, value) # finds the first instance of card in hand
    @cards.each.with_index do |c, index|
      if (c.suit.casecmp?(suit) && c.value.casecmp?(value))
        return index
      end
    end
    return nil
  end

  def find(card) # finds the first instance of card in hand
    @cards.each.with_index do |c, index|
      if (c.suit.casecmp?(card.suit) && c.value.casecmp?(card.value))
        return index
      end
    end
    return nil
  end

  def find_byValue(value) # finds multiple instances of value in hand
    found = Array.new(0)
    @cards.each.with_index do |c, index|
      if c.value.casecmp?(value)
        found << index
      end
    end
    return found
  end

  def remove_byValue(value)
    removed = []

    index = 0
    while index < @cards.length
      c = @cards[index]
      if c.value.casecmp?(value)
        removed << remove(index)
      else
        index += 1
      end
    end

    #@cards.each.with_index do |c, index|
    #  p "c: #{c.name}, index: #{index}"
    #  if c.value.casecmp?(value)
    #    p "removed"
    #    removed << remove(index)
    #  end
    # end
    return removed
  end


  def sort_bySuit
    Card.sort_bySuit(@cards)
  end

  def sort_byValue
    Card.sort_byValue(@cards)
  end

  def flip
    @cards.reverse
  end

end

# hand = Hand.new
# card = Card.new("Clubs", "Ace")
# card2 = Card.new("Diamonds", "Queen")
# card3 = Card.new("Diamonds", "Queen")
# hand.add(card)
# hand.add(card2)

# p hand.getCards
# p "Queen of Diamonds is at index #{x = hand.find("Diamonds", "Queen")}"
# hand.remove(x)
# p hand.getCards
