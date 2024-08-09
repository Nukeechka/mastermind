# frozen_string_literal: true

require './lib/board'
require './lib/human'
require './lib/computer'

# class Game
class Game
  def initialize
    @human = Human.new
    @computer = Computer.new
    @board = Board.new
  end

  def secret_code
    @computer.create_secret_code(@board.colors)
  end

  def check_code(guessed_code, secret_code)
    @board.check_code(guessed_code, secret_code)
  end

  def all_match?(hints)
    @board.all_match?(hints)
  end

  def show_results(result, title)
    print "#{title}: "
    result.each do |value|
      print "| #{value} |"
    end
    puts
    puts
  end

  def guess_colors
    @human.guess_colors
  end

  def play # rubocop:disable Metrics/MethodLength
    secret = secret_code
    12.times do
      show_results(@board.colors, 'All colors')
      # show_results(secret, 'Secret code')
      guess = guess_colors
      show_results(guess, 'Guessed colors')
      result = check_code(secret, guess)
      show_results(result, 'Matches')

      if all_match?(result)
        puts 'Well done! You win!'
        break
      end
    end
    show_results(secret, 'Secret code was')
    puts 'Game finished!'
  end
end
