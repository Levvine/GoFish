class TestPlayer

  # testing dangerous ways to access array instances

  attr_reader :name
  attr_reader :isBot
  attr_reader :hand

  def initialize(name, isBot)
    @name = name
    @isBot = isBot
    @hand = [1,2,3,4]
  end

  def numCards
    return @hand.length
  end

  def insertCard
  end

end
