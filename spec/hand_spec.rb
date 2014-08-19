require 'rspec'
require 'hand'
require 'deck'

RSpec.describe "Hand" do
  let(:royal_flush_deck) { Deck.new([
    Card.new(:ace, :hearts),
    Card.new(:king, :hearts),
    Card.new(:queen, :hearts),
    Card.new(:jack, :hearts),
    Card.new(:ten, :hearts)
  ])}
  let(:straight_flush_deck) { Deck.new([
    Card.new(:nine, :spade),
    Card.new(:king, :spade),
    Card.new(:queen, :spade),
    Card.new(:jack, :spade),
    Card.new(:ten, :spade)
  ])}
  let(:four_of_a_kind_deck) { Deck.new([
    Card.new(:deuce, :diamonds),
    Card.new(:deuce, :clubs),
    Card.new(:deuce, :spades),
    Card.new(:deuce, :hearts),
    Card.new(:five, :diamonds)
  ])}
  let(:full_house_deck) { Deck.new([
    Card.new(:seven, :hearts),
    Card.new(:seven, :clubs),
    Card.new(:six, :diamonds),
    Card.new(:six, :clubs),
    Card.new(:six, :hearts)
  ])}
  let(:flush_deck) { Deck.new([
    Card.new(:ace, :hearts),
    Card.new(:seven, :hearts),
    Card.new(:deuce, :hearts),
    Card.new(:king, :hearts),
    Card.new(:five, :hearts)
  ]) }
  let(:straight_deck) { Deck.new([
    Card.new(:deuce, :hearts),
    Card.new(:three, :hearts),
    Card.new(:four, :diamonds),
    Card.new(:five, :spades),
    Card.new(:six, :spades)
  ])}
  let(:three_of_a_kind_deck) { Deck.new([
    Card.new(:five, :hearts),
    Card.new(:five, :spades),
    Card.new(:five, :diamonds),
    Card.new(:seven, :hearts),
    Card.new(:eight, :hearts)
  ])}
  let(:two_pair_deck) { Deck.new([
    Card.new(:ace, :hearts),
    Card.new(:ace, :spades),
    Card.new(:five, :diamonds),
    Card.new(:seven, :hearts),
    Card.new(:seven, :diamonds)
  ])}
  let(:one_pair_deck) { Deck.new([
    Card.new(:ace, :hearts),
    Card.new(:ace, :spades),
    Card.new(:five, :diamonds),
    Card.new(:eight, :hearts),
    Card.new(:seven, :diamonds)
  ])}
  let(:high_card_deck) { Deck.new([
    Card.new(:ace, :hearts),
    Card.new(:five, :diamonds),
    Card.new(:ten, :clubs),
    Card.new(:eight, :hearts),
    Card.new(:seven, :diamonds)
  ])}
  let(:hand1) { Hand.new(royal_flush_deck) }
  let(:hand2) { Hand.new(straight_flush_deck) }
  let(:hand3) { Hand.new(four_of_a_kind_deck) }
  let(:hand4) { Hand.new(full_house_deck) }
  let(:hand5) { Hand.new(flush_deck) }
  let(:hand6) { Hand.new(straight_deck) }
  let(:hand7) { Hand.new(three_of_a_kind_deck) }
  let(:hand8) { Hand.new(two_pair_deck) }
  let(:hand9) { Hand.new(one_pair_deck) }
  let(:hand10){ Hand.new(high_card_deck) }
  
  
  it "only has five cards in a hand" do
    expect(hand1.count).to eql(5)
  end
  
  describe "draw from deck" do
    let(:test_deck) { Deck.new }
    
    before(:each) do
      h = Hand.new(test_deck)
    end
    
    it "draws from the deck" do
      expect(test_deck.count).to eql(47)
    end
  end
  
  describe "evaluate hands" do 
    
    describe "#is_royal_flush?" do
      it "correctly identifies a royal flush hand" do
        expect(hand1.is_royal_flush?).to eql(true)
      end
      
      it "correctly identifies non-royal flush hands" do
        expect(hand8.is_royal_flush?).to eql(false)
      end
    end
    
    describe "#is_straight_flush?" do
      it "correctly identifies a straight flush hand" do
        expect(hand2.is_straight_flush?).to eql(true)
      end
      
      it "correctly identifies non-straight flush hands" do
        expect(hand8.is_straight_flush?).to eql(false)
      end
    end
    
    describe "#is_four_of_a_kind?" do
      it "correctly identifies a four of a kind hand" do
        expect(hand3.is_four_of_a_kind?).to eql(true)
      end
      
      it "correctly identifies non-four of a kind hands" do
        expect(hand8.is_four_of_a_kind?).to eql(false)
      end
    end
    
    describe "#is_full_house?" do
      it "correctly identifies a full house hand" do
        expect(hand4.is_full_house?).to eql(true)
      end
      
      it "correctly identifies non-full house hands" do
        expect(hand8.is_full_house?).to eql(false)
      end
    end
    
    describe "#is_flush?" do
      it "correctly identifies a flush hand" do
        expect(hand5.is_flush?).to eql(true)
      end
      
      it "correctly identifies non-slush hands" do
        expect(hand8.is_flush?).to eql(false)
      end
    end
    
    describe "#is_straight?" do
      it "correctly identifies a straight hand" do
        expect(hand6.is_straight?).to eql(true)
      end
      
      it "correctly identifies non-straight hands" do
        expect(hand8.is_straight?).to eql(false)
      end
    end
    
    describe "#is_three_of_a_kind?" do
      it "correctly identifies a three of a kind hand" do
        expect(hand7.is_three_of_a_kind?).to eql(true)
      end
      
      it "correctly identifies non-three of a kind hands" do
        expect(hand8.is_three_of_a_kind?).to eql(false)
      end
    end
    
    describe "#is_two_pair?" do
      it "correctly identifies a two pair hand" do
        expect(hand8.is_two_pair?).to eql(true)
      end
      
      it "correctly identifies non-two pair hands" do
        expect(hand1.is_two_pair?).to eql(false)
      end
    end
    
    describe "is_one_pair?" do
      it "correctly identifies a one pair hand" do
        expect(hand9.is_one_pair?).to eql(true)
      end
      
      it "correctly identifies non-one pair hands" do
        expect(hand1.is_one_pair?).to eql(false)
      end
    end
    
    describe "get_high_card" do
      it "correctly identifies high card" do
        expect(hand10.get_high_card.value).to eql(:ace)
      end
    end
    
    describe "beats?" do
      it "identifies the better hand" do
        expect(hand1.beats?(hand2)).to eql(true)
        expect(hand2.beats?(hand1)).to eql(false)
        expect(hand5.beats?(hand8)).to eql(true)
      end
    end
  end
end