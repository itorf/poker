require_relative 'errors'

class Player
  attr_accessor :name, :bankroll, :hand, :fold, :bet
  
  def initialize(name, bankroll)
    @name = name
    @bankroll = bankroll
    @hand = nil
    @fold = false
    @bet = 0
  end
  
  def set_game(game)
    @game = game
  end
  
  def get_hand(hand)
    @hand = hand
  end
  
  def discard(cards)
    raise DiscardTooManyCardsError.new("Choose 3 or fewer cards") unless cards.length <= 3
    cards.each do |card|
      raise "Card not in hand" unless hand.contains?(card)
    end
    @hand.replace_cards(cards)
  end
  
  def swap_cards
    puts "#{ @name }'s Cards:"
    @hand.render
    puts "Choose cards to swap"
    begin
      input = gets.chomp
      input_arr = input.split(",")
      discards = []
      input_arr.each do |i|
        n = Integer(i)
        raise InvalidInputError.new("Choose from 0 to 4") unless n.between?(0,4)
        discards << @hand[n]
      end
    rescue ArgumentError => e
      puts "Input numbers, separated by commas"
      retry
    rescue InvalidInputError => e
      puts e.message
      retry
    end
    discard(discards)
  end
  
  def fold_cards
    @fold = true
  end
  
  def take_turn current_stakes
    puts "#{ @name }'s Cards:"
    @hand.render
    puts "You have #{ @bankroll }"
    min_bet = current_stakes - @bet
    puts "Fold, call, or raise (#{ min_bet.to_s } to call)"
    begin
      input = gets.chomp.downcase
      parse_input(input, min_bet)
    rescue InvalidInputError => e
      puts e.message
      retry
    rescue NotEnoughMoneyError => e
      puts e.message
      retry
    end
  end
  
  def parse_input(input, min_bet)
    if input == "fold"
      fold_cards
      return 0
    elsif input == "call"
      make_bet(min_bet)
      return 0
    else
      input_arr = input.split(" ")
      raise InvalidInputError.new("Type fold, call, or raise amount") unless input_arr[0] == "raise"
      bet_amt = Integer(input_arr[1])
      make_bet(min_bet + bet_amt)
      return bet_amt
    end
  end
  
  def make_bet(amount)
    raise NotEnoughMoneyError.new "Not enough cash" unless amount <= @bankroll
    @bankroll -= amount
    @game.pot += amount
    @bet += amount
  end
end