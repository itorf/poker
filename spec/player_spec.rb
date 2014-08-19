require 'rspec'
require 'player'
require 'game'
require 'errors'

RSpec.describe "Player" do
  subject(:player) { Player.new("test", 1000) }
  let(:card1) { Card.new(:ace, :hearts) }
  let(:card2) { Card.new(:five, :diamonds) }
  let(:card3) { Card.new(:ten, :clubs) }
  let(:card4) { Card.new(:eight, :hearts) }
  let(:card5) { Card.new(:seven, :diamonds) }
  let(:card6) { Card.new(:ace, :diamonds) }
  let(:card7) { Card.new(:ace, :clubs) }
  let(:deck) { Deck.new([card1,card2,card3,card4,card5, card6, card7]) }
  let(:hand) { Hand.new(deck) }
  let(:game) { Game.new([player]) }
  
  before(:each) do
    player.get_hand(hand)
  end
  
  it "should be initialized with money" do
    expect(player.bankroll).to_not eql(nil)
  end
  
  it "should have a hand" do
    expect(player.hand).to_not eql(nil)
  end
  
  describe "#discard" do
    before(:each) do
      player.discard([card1, card2])
    end
    
    it "should remove the cards from the hand" do
      expect(player.hand.contains?(card1)).to eql(false)
      expect(player.hand.contains?(card2)).to eql(false)
      expect(player.hand.contains?(card3)).to eql(true)
    end
    
    it "draws back up to five cards" do
      expect(player.hand.count).to eql(5)
      expect(player.hand.contains?(card6)).to eql(true)
      expect(player.hand.contains?(card7)).to eql(true)
    end
  end
  
  describe "#fold" do
    before(:each) do
      player.parse_input("fold", 0)
    end
    
    it "should make the player fold" do
      expect(player.fold).to eql(true)
    end
  end
  
  describe "#parse_input" do
    it "should raise an error on invalid input" do
      expect do
        player.parse_input("Nothing", 100)
      end.to raise_error(InvalidInputError)
    end
  end
  
  describe "#make_bet" do
    before(:each) do
      player.set_game(game)
      player.parse_input("raise 100", 0)
    end
  
    it "should decrease players amount by the bet amount" do
      expect(player.bankroll).to eql(900)
    end
    
    it "should raise an error if you bet more than you have" do
      expect do
        player.make_bet(2000)
      end.to raise_error(NotEnoughMoneyError)
    end
   
    it "should increment the game's pot" do 
      expect(game.pot).to eql(100)
    end
  end
end