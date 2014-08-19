require_relative 'card'

class Deck

  def self.full_deck
    deck = []
    Card.suits.each do |suit|
      Card.values.each do |value|
        deck << Card.new(value, suit)
      end
    end
    deck.shuffle!
  end
  
  def initialize(default = nil)
    default = Deck.full_deck if default.nil?
    @cards = default
  end
  
  def count
    @cards.count
  end
  
  def take(n)
    @cards.shift(n)
  end
  
  def return(return_cards)
    @cards += return_cards
  end
end