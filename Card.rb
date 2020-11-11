class Card

  @@suit =  ["Clubs", "Diamonds", "Hearts", "Spades" ] # Bridge Ranking
  @@value = [nil, "Ace", "Two", "Three", "Four", "Five", "Six", "Seven",
            "Eight", "Nine", "Ten","Jack", "Queen", "King"]

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def self.suits
    return @@suit.clone
  end

  def self.values
    return @@value.clone
  end

  def self.sort_bySuit(cards)
    cards.sort_by! { |c| [@@suit.index(c.suit), @@value.index(c.value)] }
  end

  def self.sort_byValue(cards)
    cards.sort_by! { |c| [@@value.index(c.value), @@suit.index(c.suit)] }
  end

  def self.sortSuit(suits)
    suits.sort_by! { |s| @@suit.index(s) }
  end

  def self.sortValue(values)
    values.sort_by! { |v| @@value.index(v) }
  end

  def suit
    return @suit
  end

  def value
    return @value
  end

  def name
    return "#{@value} of #{@suit}"
  end

  def ==(other_card)
    return @suit == other_card.suit && @value == other_card.value
  end

end
