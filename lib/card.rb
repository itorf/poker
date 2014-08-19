# -*- coding: utf-8 -*-
require 'colorize'

class Card
  SUIT_STRINGS = {
    :clubs    => "♣".colorize(:black),
    :diamonds => "♦".colorize(:red),
    :hearts   => "♥".colorize(:red),
    :spades   => "♠".colorize(:black)
  }

  VALUE_STRINGS = {
    :deuce => "2",
    :three => "3",
    :four  => "4",
    :five  => "5",
    :six   => "6",
    :seven => "7",
    :eight => "8",
    :nine  => "9",
    :ten   => "10",
    :jack  => "J",
    :queen => "Q",
    :king  => "K",
    :ace   => "A"
  }
  
  def self.suits
    SUIT_STRINGS.keys
  end
  
  def self.values
    VALUE_STRINGS.keys
  end
    
  attr_reader :value, :suit
  
  def initialize(value, suit)
    @value = value
    @suit = suit
  end
  
  def higher_than?(other_card)
    self.convert_value > other_card.convert_value
  end
  
  def render_card
    VALUE_STRINGS[@value] + SUIT_STRINGS[@suit]
  end
  
  def convert_value
    case @value
    when :deuce
      2
    when :three
      3
    when :four
      4
    when :five
      5
    when :six
      6
    when :seven
      7
    when :eight
      8
    when :nine
      9
    when :ten
      10
    when :jack
      11
    when :queen
      12
    when :king
      13
    when :ace
      14
    end
  end

end