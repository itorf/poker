require 'rspec'
require 'deck'

RSpec.describe "Deck" do
  subject(:deck) { Deck.new }
  let(:card1) { Card.new(:ace, :spade) }
  let(:card2) { Card.new(:king, :hearts) }
  let(:card3) {  Card.new(:queen, :diamonds) }
  
  it "creates a new deck of 52 cards" do
    expect(deck.count).to eql(52)
  end
  
  describe "#take" do
    let(:deck2) { Deck.new([card1, card2, card3]) }

    it "deals out cards from the top of the deck" do
      expect(deck2.take(2)).to eql([card1, card2])
      expect(deck2.count).to eql(1)
    end
  end
  
  describe "#return" do
    let(:deck3) { Deck.new([card1]) }

    it "returns cards to the deck" do
      deck3.return([card2, card3])
      expect(deck3.count).to eql(3)
    end
  end
end