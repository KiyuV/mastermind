# frozen_string_literal: true

require './mastermind'

def main
  puts '----- Welcome to Mastermind! -----'
  puts "\nPlease enter your name:"
  name = gets.chomp
  puts 'Would you like to be the codemaker (m) or codebreaker (b)? (m/b)'
  game = Mastermind.new(name, gets.chomp)
  game.play
end

main
