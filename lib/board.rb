# frozen_string_literal: true

# module Colors
module Colors
  COLORS = %w[red green blue yellow brown orange black white].freeze
end

# class Board
class Board
  include Colors

  def colors
    Colors::COLORS
  end

  def normalize_hints(hints)
    hints.push('nothing') until hints.length == 4
    hints
  end

  def check_code(secret_code, guessed_code)
    check_code_white(guessed_code, check_code_red(secret_code, guessed_code))
  end

  def check_code_red(secret_code, guessed_code)
    hints = []
    temp_secret = secret_code.map(&:downcase)
    guessed_code.each_with_index do |color, index|
      if temp_secret.include?(color) && temp_secret[index] == (color) # rubocop:disable Style/Next
        hints.push('red pin')
        temp_index = temp_secret.index(color)
        temp_secret[temp_index] = 'match'
      end
    end
    [temp_secret, hints]
  end

  def check_code_white(guessed_code, check_code_red) # rubocop:disable Metrics/MethodLength
    red_result = check_code_red
    hints = red_result[1]
    temp_secret = red_result[0].map(&:downcase)
    guessed_code.each do |color|
      if temp_secret.include?(color) # rubocop:disable Style/Next
        hints.push('white pin')
        temp_index = temp_secret.index(color)
        temp_secret[temp_index] = 'match'
        p temp_secret
      end
    end
    normalize_hints(hints)
  end

  def all_match?(hints)
    return true if hints.all?('red pin')

    false
  end
end
