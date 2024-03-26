# frozen_string_literal: true

require './npc'
require './player'

class Mastermind
  def initialize(player)
    @guesses = 0
    @npc = NPC.new
    @player = Player.new(player)
  end

  def play
    puts "\n---secret code generated!---"
    puts "\nEnter your guess, #{@player.name}!"
    12.times do
      player_guess = gets.chomp.split('').map(&:to_i)
      increment_guess
      puts "Guess ##{@guesses}, #{player_guess.join('')}"
      @npc.code_accessor(player_guess)
      exit if player_guess == @npc.secret_code
    end
    puts "Mission falied, better luck next time #{@player.name}! The secret code was #{@npc.secret_code.join('')}"
  end

  private

  def increment_guess
    @guesses += 1
  end
end
