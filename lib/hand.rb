require_relative 'card'
require_relative 'deck'

class Hand
  def initialize(deck)
    @deck = deck
    @cards = @deck.take(5)
  end
  
  def count
    @cards.count
  end
  
  def [](pos)
    @cards[pos]
  end
  
  def contains?(check_card)
    @cards.any? { |card| check_card == card }
  end
  
  def replace_cards(cards)
    @cards -= cards
    @cards += @deck.take(cards.length)
  end
  
  def render
    @cards.each_with_index do |card, i|
      puts "Card #{ i }: #{card.render_card}"
    end
  end
  
  def beats?(other_hand)
    method_list = [
      Proc.new { |hand| hand.is_royal_flush? },
      Proc.new { |hand| hand.is_straight_flush? },
      Proc.new { |hand| hand.is_four_of_a_kind? },
      Proc.new { |hand| hand.is_full_house? },
      Proc.new { |hand| hand.is_flush? },
      Proc.new { |hand| hand.is_straight? },
      Proc.new { |hand| hand.is_three_of_a_kind? },
      Proc.new { |hand| hand.is_two_pair? },
      Proc.new { |hand| hand.is_one_pair? }
    ]
    
    method_list.each do |method|
      if method.call(self) && !method.call(other_hand)
        return true
      elsif !method.call(self) && method.call(other_hand)
        return false
      elsif method.call(self) && method.call(other_hand)
        return self.get_high_card.higher_than?(other_hand.get_high_card)
      else
        next
      end
    end    
  
    self.get_high_card.higher_than?(other_hand.get_high_card)
  end
  
  def is_royal_flush?
    if is_straight_flush?
      return true if @cards.any? { |card| card.value == :king } && @cards.any? { |card| card.value == :ace }
    end
    false
  end
  
  def is_straight_flush?
    is_flush? && is_straight?
  end
  
  def is_four_of_a_kind?
    @cards.each_with_index do |card1, idx|
      card_count = 1
      @cards.each_with_index do |card2, idy|
        next if idx >= idy
        card_count += 1 if card1.value == card2.value
        return true if card_count == 4
      end
    end
    false
  end
  
  def is_full_house?
    return false unless is_three_of_a_kind?
    card_counts = Hash.new { 0 }
    @cards.each do |card|
      card_counts[card.value] += 1
    end
    card_counts.length == 2
  end
  
  def is_flush?
    check_suit = @cards[0].suit
    @cards.all? { |card| card.suit == check_suit }
  end
  
  def is_straight?
    high_card = get_high_card
    5.times do |i|
      return false unless @cards.any? do |card|
        card.convert_value == high_card.convert_value - i
      end
    end
    true
  end
  
  def is_three_of_a_kind?
    @cards.each_with_index do |card1, idx|
      card_count = 1
      @cards.each_with_index do |card2, idy|
        next if idx >= idy
        card_count += 1 if card1.value == card2.value
        return true if card_count == 3
      end
    end
    false
  end
  
  def is_two_pair?
    pair_count = 0
    @cards.each_with_index do |card1, idx|
      @cards.each_with_index do |card2, idy|
        next if idx >= idy
        pair_count += 1 if card1.value == card2.value
      end
    end
    pair_count == 2
  end
  
  def is_one_pair?
    @cards.each_with_index do |card1, idx|
      @cards.each_with_index do |card2, idy|
        next if idx >= idy
        return true if card1.value == card2.value
      end
    end
    false
  end
  
  def get_high_card
    high_card = @cards[0]
    @cards.each do |card|
      high_card = card if card.higher_than?(high_card)
    end
    high_card
  end
end