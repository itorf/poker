require 'rspec'
require 'game'

RSpec.describe "Game" do
  let(:p1) { Player.new("p1", 1000) }
  let(:players) { [Player.new("test1", 1000), p1, Player.new("test2", 1000)] }
  let(:game) { Game.new(players) }
  
  it "is created with a new deck" do
    expect(game.deck.count).to eql(52)
  end
  
  it "should take in players" do 
    expect(game.players.count).to eql(3)
  end
  
  it "should keep track of pot" do
    expect(game.pot).to eql(0)
  end
end