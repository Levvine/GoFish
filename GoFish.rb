require_relative 'Deck'
require_relative 'Player'

class GoFish

  def initialize(deck, *players)
      @deck = deck
      @players = []

      players.each do |p|
        @players.append p
        @deck.deal(p, 7)
      end
      @books = Array.new(@players.length){[]}
      @completed = []
  end


  def to_value(s)

    if s.length == 1 || s.length == 2

      case s.downcase
      when 'a'
        return 'Ace'
      when '1'
        return 'Ace'
      when '2'
        return 'Two'
      when '3'
        return 'Three'
      when '4'
        return 'Four'
      when '5'
        return 'Five'
      when '6'
        return 'Six'
      when '7'
        return 'Seven'
      when '8'
        return 'Eight'
      when '9'
        return 'Nine'
      when '10'
        return 'Ten'
      when 'j'
        return 'Jack'
      when 'q'
        return 'Queen'
      when 'k'
        return 'King'
      end

    else

      case s.downcase
      when 'ace'
        return 'Ace'
      when 'two'
        return 'Two'
      when 'three'
        return 'Three'
      when 'four'
        return 'Four'
      when 'five'
        return 'Five'
      when 'six'
        return 'Six'
      when 'seven'
        return 'Seven'
      when 'eight'
        return 'Eight'
      when 'nine'
        return 'Nine'
      when 'ten'
        return 'Ten'
      when 'jack'
        return 'Jack'
      when 'queen'
        return 'Queen'
      when 'king'
        return 'King'
      end

    end

  end


  def bookCheck(player, index)

    newBooks = Hash.new(0)
    player.hand.getCards.each do |c|
      newBooks[c.value] += 1
    end
    newBooks.select!{ |key, value| value == 4 }

    if newBooks.length > 0
      newBooks.each_key do |v|
        puts "#{player.name} has completed book #{v}!"
        @books[index].push(v)
        player.hand.remove_byValue(v)
        @completed << v
        Card.sortValue(@books[index])
      end
    end

  end


  def sort(player)
    player.hand.sort_byValue
  end


  def start

    puts "Go Fish"
    print "Players: "
    @players.each.with_index(1) { |p, index| print "#{index}. #{p.name}, " }
    puts "\b\b "

    unless @players.map { |p| p.name.downcase }.uniq! == nil
      raise "Player names are not unique"
    end

    # define wincon = max number of books
    puts "Rules: All players are dealt 7 cards."
    puts "The winner is the collector of the most books at the end of the game."


    # precheck completed books
    puts "\nPrecheck completed books:"
    @players.each.with_index do |p, index|
      newBooks = bookCheck(p, index)
    end

    turn = 0

    while true
      currentPlayer = @players[turn]
      puts "\n==== #{currentPlayer.name}'s Turn ===="

      sort(currentPlayer)
      if !currentPlayer.isBot # if player is not a bot begin

        puts "|| Your Hand:"
        currentPlayer.hand.getCards.each do |c|
          puts "#{c.value} of #{c.suit}"
        end


        while true

          print "\nWho will you ask for a card?\n> "
          target = $stdin.gets.chomp
          if target.to_i - 1 == turn
            # do nothing
          elsif currentPlayer.name.casecmp?(target)
            # do nothing
          elsif target.to_i.between?(1, @players.length)
            # assigns player to target based on turn
            target = @players[target.to_i - 1]
            break
          elsif target = @players.find { |p| p.name.casecmp?(target) }
            # assigns player to target based on name
            break
          end
          puts "Error: Invalid target."

        end

        while true

          print "\nWhat card do you ask #{target.name} for?\n> "
          value_of_interest = to_value($stdin.gets.chomp)

          if !value_of_interest
            puts "Error: Invalid card value."
          elsif @completed.find { |v| v == value_of_interest }
            puts "Error: Requested value is already completed."
          else
            break
          end

        end

      # if player is not a bot end
      else # if player is a bot

        validTargets = @players - [currentPlayer]
        target = validTargets.sample

        value_of_interest = (Card.values[1 ,Card.values.length] -
                             @completed).sample

      end # end variable retrieval

      puts "Requested #{value_of_interest} from #{target.name}..."

      # begin variable calculations

      removed = target.hand.remove_byValue(value_of_interest)

      if removed.length == 0
        puts "Go Fish!"

        fish = @deck.deal(currentPlayer, 1)[0]

        unless currentPlayer.isBot
          puts "\nDrew #{fish.value} of #{fish.suit}."
        end

      else
        print "#{target.name} gave "
        removed.each do |c|
          print c.name
          print ", "
        end
        puts "\b\b to #{currentPlayer.name}."
        currentPlayer.hand.add(*removed)
      end

      newBooks = bookCheck(currentPlayer, turn)

      if @deck.size == 0 && currentPlayer.hand.empty
        break
      else
        puts "Cards remaining in deck: #{@deck.size}"
      end

      puts "\n|| Completed books:"
      @books.each.with_index do |b, index|
        print "#{@players[index].name} (#{b.length}), "
      end
      puts "\b\b "

      puts "\nPress Enter to Continue"
      print "> "
      debug = $stdin.gets.chomp

      if debug == "debug"
        p "Exiting game Reason: Debug"
        p @books
        break
      end

      if fish # if player fished
        if turn < @players.length - 1 # pass turn
          turn += 1
        else
          turn = 0
        end
        fish = nil
      end

    end # end turn while(true) loop

    puts "All books have been completed."

    winnerName = Array.new(1, "")
    winnerBookCount = Array.new(1, 0)
    puts "\n|| Completed books:"
    @books.each.with_index do |b, index|
      if b.length > winnerBookCount[0]
        winnerName.clear
        winnerBookCount.clear
        winnerName[0] = @players[index].name
        winnerBookCount[0] = b.length
      elsif b.length == winnerBookCount[0]
        winnerName << @players[index].name
        winnerBookCount << b.length
      end
      print "#{@players[index].name} (#{b.length}): "
      b.each { |v| print "#{v}, "}
      puts "\b\b "
    end

    # print winners
    puts "\nWinner: "
    winnerName.each.with_index do |w, index|
      print "#{w} (#{winnerBookCount[index]}), "
    end
    puts "\b\b "

    puts "\nPress Enter to Continue"
    print "> "
    $stdin.gets

  end

end

deck = Deck.new
deck.shuffle
player = Player.new("Player", false)
cpu1 = Player.new("CPU1", true)
playerError = Player.new("player", false)
game = GoFish.new(deck, player, cpu1)
game.start
