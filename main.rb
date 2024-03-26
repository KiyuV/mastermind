# frozen_string_literal: true

require './mastermind'

def main
  puts "Welcome to Mastermind!\nPlease enter your name"
  game = Mastermind.new('bob') # gets.chomp
  game.play
end

main
