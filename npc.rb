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
      @current_guess = '1111'
      @current_pegs = [0, 0]
      @prev_total_pegs = 0
      @total_pegs = 0
      @total_peg_diff = 0
      @current_digit = 1
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
    @current_pegs = pegs.split(' ').map(&:to_i)
    # return true if there are 4 black pegs
    return unless @current_pegs[0] == 4

    true
  end

  def make_guess
    @prev_total_pegs = @total_pegs
    @total_pegs = @current_pegs[0] + @current_pegs[1]
    peg_diff = @total_pegs - @prev_total_pegs

    if @total_pegs.zero?
      @all_codes = @all_codes.reject { |num| num.include?(@current_digit.to_s) }
      @current_digit += 1
      @current_guess = @all_codes[0]

    elsif @total_pegs == 4
      @all_codes.delete(@current_guess)
      correct_digits = {}

      @current_guess.split('').each do |digit|
        if correct_digits[digit.to_s]
          correct_digits[digit.to_s] += 1
        else
          correct_digits[digit.to_s] = 1
        end
      end

      unique_digits = correct_digits.keys
      num_of_digits = correct_digits.values

      # removing any codes which do no satisfy the values in the hash
      @all_codes = @all_codes.select do |code|
        did_pass = false
        unique_digits.each_with_index do |digit, ind|
          if code.include?(digit) && code.scan(digit).count == num_of_digits[ind]
            did_pass = true
          else
            did_pass = false
            break
          end
        end
        did_pass
      end
      # from the thinned out list of codes ramdomly select one to use as next guess
      next_guess = @all_codes.sample
      @current_guess = next_guess

    elsif peg_diff >= 0
      # no improvement from previous guess, remove codes that contain the current digit
      if @total_pegs == @prev_total_pegs
        @all_codes = @all_codes.reject { |num| num.include?(@current_digit.to_s) }
        p @all_codes.length
      end
      next_guess = @current_guess[0, peg_diff + @total_peg_diff]
      @current_digit += 1

      (4 - (peg_diff + @total_peg_diff)).times do
        next_guess << @current_digit.to_s
      end

      @total_peg_diff += peg_diff
      @current_guess = next_guess
    end
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
