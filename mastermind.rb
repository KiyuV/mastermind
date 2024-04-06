# frozen_string_literal: true

require './npc'
require './player'

class Mastermind
  def initialize(player, choice)
    @guesses = 0
    @npc = NPC.new(choice)
    @player = Player.new(player)
    @choice = choice
  end

  def play
    if @choice == 'b'
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
    else
      increment_guess
      puts "\nGuess ##{@guesses} - 1111"
      puts 'How many black and white pegs are there?'
      @npc.get_response(gets.chomp)

      11.times do
        increment_guess
        puts "\nGuess ##{@guesses} - #{@npc.make_guess}"
        puts 'How many black and white pegs are there?'
        next unless @npc.get_response(gets.chomp)

        puts "\nCode Broken! Thank you for playing!"
        exit
      end

      puts "\nI was unable to break the code. Good work, #{@player.name}!"
      puts "\n----- Congratulations, You win! -----"
    end
  end

  private

  def increment_guess
    @guesses += 1
  end
end
