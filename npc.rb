# frozen_string_literal: true

class NPC
  attr_reader :secret_code

  def initialize
    @code_range = [1, 2, 3, 4, 5, 6]
    @secret_code = code_generator
    @black_pegs = 0
    @white_pegs = 0
  end

  def code_accessor(code)
    reset_pegs
    tmp_secret_code = @secret_code.clone
    tmp_code = code.clone
    code.each_with_index do |digit, ind|
      next unless digit == @secret_code[ind]

      tmp_secret_code[ind] = ''
      tmp_code[ind] = ''
      @black_pegs += 1
    end
    # To determine the number of white pegs
    tmp_code.each_with_index do |digit, ind|
      next unless digit != '' && tmp_secret_code.include?(digit)

      index = tmp_secret_code.index(digit)
      tmp_secret_code[index] = ''
      tmp_code[ind] = ''
      @white_pegs += 1
    end
    to_s
  end

  private

  # generates the secret code
  def code_generator
    code = []
    4.times do
      code.push(@code_range.sample)
    end
    code
  end

  def to_s
    if @black_pegs == 4
      puts 'You cracked the code!'
    else
      puts "#{@black_pegs} black pegs and #{@white_pegs} white pegs"
      puts
    end
  end

  def reset_pegs
    @black_pegs = 0
    @white_pegs = 0
  end
end
