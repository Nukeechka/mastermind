# frozen_string_literal: true

require './lib/player'

# class Human
class Human < Player
  def guess_colors
    puts 'Enter a four colors (after each color down enter):'
    guessed_colors = []
    4.times do
      guess = gets.chomp
      guessed_colors.push(guess)
    end
    guessed_colors
  end
end
