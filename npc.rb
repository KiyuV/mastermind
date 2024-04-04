class NPC
  attr_reader :secret_code

  def initialize(choice)
    if choice == 'b'
      @code_range = [1, 2, 3, 4, 5, 6]
      @secret_code = code_generator
      @black_pegs = 0
      @white_pegs = 0
    else
      @code_range = %w[1 2 3 4 5 6]
      @all_codes = possible_codes
    end
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

  def get_response(pegs)
    @current_pegs = pegs.split(' ')

    return unless @current_pegs[0] == '4'

    true
  end

  def make_guess
    guess = ''
    4.times do
      guess << @code_range.sample
    end
    guess
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
      puts 'You cracked the code! Well Done!'
    else
      puts "#{@black_pegs} black pegs and #{@white_pegs} white pegs"
      puts
    end
  end

  def reset_pegs
    @black_pegs = 0
    @white_pegs = 0
  end

  # generates all possible secret codes
  def possible_codes
    all_possible_codes = []
    @code_range.each do |value1|
      current_code = ''
      current_code << value1
      @code_range.each do |value2|
        current_code << value2
        @code_range.each do |value3|
          current_code << value3
          @code_range.each do |value4|
            current_code << value4
            all_possible_codes.push(current_code)
            current_code = current_code.chop
          end
          current_code = current_code.chop
        end
        current_code = current_code.chop
      end
    end
    all_possible_codes
  end
end
