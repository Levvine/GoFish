require_relative 'TestPlayer'
require_relative 'Card'
require_relative 'Player'

# if at least one value is true, returns true
def truthTest
  truth = [true, false]
  truth.each do |t|
    if (t)
      return true
    end
  end
  return false
end

p truthTest

# Ruby getter/setter scope test
# want to know if Ruby handles encapsulation of data types like Java
tp = TestPlayer.new("TestPlayerUnmodified", false)
tpName = tp.name # using single data type
puts "tp.name = #{tp.name} | tpName = #{tpName}"
tpName = "TestPlayerModified"
puts "tp.name = #{tp.name} | tpName = #{tpName}"
# result: changing tpName does not affect instance variable name of tp
tpHand = tp.hand
puts "tp.hand = #{tp.hand} | tpHand = #{tpHand}"
tpHand[0] = "Change"
puts "tp.hand = #{tp.hand} | tpHand = #{tpHand}"
# result: changing individual elements of tpHand affects the original instance
tpHand = ["This","is","a","different","array"]
puts "tp.hand = #{tp.hand} | tpHand = #{tpHand}"
# result: tpHand points to a different memory location
# moral is to return an array clone if necessary to access entire array

# empty string cannot use string methods
s = $stdin.gets.chomp
p s.split(' ')[0].to_s.downcase.length

# test bookCheck method
player = Player.new("Player", false)
card1 = Card.new("Diamonds", "Ace")
card2 = Card.new("Clubs", "Ace")
card3 = Card.new("Hearts", "Ace")
card4 = Card.new("Spades", "Ace")
card5 = Card.new("Clubs", "Two")
player.hand.add(card1, card2, card3, card4, card5)
p player.hand.getCards

books = Hash.new(0)
player.hand.getCards.each do |c|
  books[c.value] += 1
end
p books.select!{ |key, value| value == 4 }
books.each_key { |b| puts b }

# test uniq
a = ["a", "c", "b"]
p a.uniq!

# testing why each with index skips in Hand.rb
# fixed | reason: undesired each loop iterate after removing card
books.each_key do |v|
  player.hand.remove_byValue(v)
end
p player.hand.getCards

# testing array sample
remove = ["King", "Jack", "Ace", "Two", "Three", "Four", "Five", "Six", "Seven",
          "Eight", "Nine", "Ten"]
p "Sample: #{(Card.values[1, Card.values.length] - remove).sample}"

# testing multiple pass of select!
p hash = {"King" => 3, "Jack" => 4}
p hash.select!{ |key, value| value == 4 }
p hash
# note: using select! will return nil if no changes are made to the hash

# testing pushing onto 2D arrays
p array = Array.new(2, [])
p array[0] << 1
p array
p goodArray = Array.new(2){[]}
p goodArray[0] << 1
p goodArray
# note: creating a 2D array with the former method results a "cloned" empty
#       array while the latter creates separate new arrays

# From ruby-doc.org
# Note that the second argument populates the array with references to the same
# object. Therefore, it is only recommended in cases when you need to
# instantiate arrays with natively immutable objects such as Symbols, numbers,
# true or false.
