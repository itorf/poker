require 'rspec'
require 'card'

RSpec.describe 'Card' do 
  let(:card) { Card.new(:ace, :spades) }
  let(:card2) { Card.new(:jack, :clubs) }
  
  it "should have a value and a suit" do
    expect(card.value).to eql(:ace)
    expect(card.suit).to eql(:spades)
  end
  
  describe "#higher_than?" do
    it "should compare card values" do
      expect(card.higher_than?(card2)).to eql(true)
      expect(card2.higher_than?(card)).to eql(false)
    end
  end
end