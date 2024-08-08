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
    puts "Secret code: #{@computer.create_secret_code(@board.colors)}"
    puts
    @computer.create_secret_code(@board.colors)
  end

  def all_colors
    print 'All colors: '
    @board.colors.each do |color|
      print "| #{color} |"
    end
    puts
    puts
  end

  def play
    secret_code
    all_colors
    @human.guess_colors
  end
end
