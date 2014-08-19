require_relative 'player'
require_relative 'deck'
require_relative 'hand'

class Game
  attr_accessor :deck, :players, :pot
  
  def initialize player_array
    @deck = Deck.new
    @players = player_array
    @players.each do |player|
      player.set_game(self)
    end
    @dealer_it = 0
    @pot = 0
  end
  
  def run
    while true
      @players.each do |player|
        player.hand = Hand.new(@deck)
      end
    
      run_betting_round
      if one_player_left
        win_and_next_round(one_player_left)
        next
      end
    
      @players.length.times do |i|
        current_player = @players[((@dealer_it + i) % @players.length)]
        current_player.swap_cards unless current_player.fold
      end
    
      run_betting_round
      if one_player_left
        win_and_next_round(one_player_left)
        next
      end
    
      winning_player = nil
      @players.each do |player|
        next if player.fold
        puts "#{ player.name }'s hand:"
        player.hand.render
        if winning_player.nil?
          winning_player = player
        elsif player.hand.beats?(winning_player.hand)
          winning_player = player
        end
      end
      win_and_next_round(winning_player)
    end
  end
  
  def run_betting_round
    @players.each do |player|
      player.bet = 0
    end
    players_left = @players.length
    current_stakes = 0
    i = 0
    until players_left == 0
      current_player = @players[((@dealer_it + i) % @players.length)]
      unless current_player.fold
        puts "Current pot: #{ @pot }"
        next_bet = current_player.take_turn(current_stakes)
        current_stakes += next_bet
        players_left = @players.length if next_bet != 0
      end
      players_left -= 1
      i += 1
      puts ""
    end
  end
  
  def one_player_left
    last_player = nil
    @players.each do |player|
      if last_player.nil? && !player.fold
        last_player = player
      elsif !last_player.nil? && !player.fold
        return nil
      end
    end
    last_player
  end
  
  def dealer
    @players[@dealer_it]
  end
  
  def win_and_next_round winning_player
    puts "-" * 20
    puts "#{ winning_player.name } wins!"
    puts "#{ winning_player.name } gets #{ @pot.to_i }"
    puts "-" * 20
    winning_player.bankroll += @pot
    @dealer_it = (@dealer_it + 1) % @players.length
    @players.each do |player|
      player.fold = false
    end
    @pot = 0
    self.run
  end
end

if $PROGRAM_NAME == __FILE__
  p1 = Player.new("P1", 1000)
  p2 = Player.new("P2", 1000)
  g = Game.new([p1, p2])
  g.run
end