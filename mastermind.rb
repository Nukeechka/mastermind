# frozen_string_literal: true

# class Mastermind
class Mastermind
  def initialize
    @code_maker = CodeMaker.new
    @code_breaker = CodeBreaker.new
    @feedback = Feedback.new
    @computer_guesser = ComputerGuesser.new
  end

  def play
    puts 'Do you want to be the code maker (1) or the code breaker (2)?'
    choice = gets.chomp.to_i

    if choice == 1
      play_as_code_maker
    elsif choice == 2
      play_as_code_breaker
    else
      puts 'Invalid choice. Exiting game.'
    end
  end

  private

  def play_as_code_maker # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
    puts 'You are the code maker. Please select your secret code (4 colors separated by spaces):'
    secret_code = gets.chomp.split
    puts "You have set the secret code. Now let's see the computer try to guess it!"

    max_attempts = 10
    attempts = 0

    while attempts < max_attempts
      guess = @computer_guesser.make_guess
      result = @feedback.evaluate(guess, secret_code)

      puts "Computer's guess: #{guess.join(' ')}"
      puts "Feedback: #{result[:feedback]}"

      if result[:correct]
        puts 'Computer guessed the code correctly!'
        return
      end

      @computer_guesser.update_possible_codes(guess, result[:feedback])
      attempts += 1
    end

    puts "Game over! The secret code was #{secret_code.join(' ')}."
  end

  def play_as_code_breaker # rubocop:disable Metrics/MethodLength
    secret_code = @code_maker.generate_code
    puts 'The computer has generated a secret code. Try to guess it!'

    max_attempts = 10
    attempts = 0

    while attempts < max_attempts
      guess = @code_breaker.make_guess
      result = @feedback.evaluate(guess, secret_code)

      if result[:correct]
        puts "Congratulations! You've guessed the code correctly!"
        return
      else
        puts "Feedback: #{result[:feedback]}"
        attempts += 1
      end
    end

    puts "Game over! The secret code was #{secret_code.join(' ')}."
  end
end

# class CodeMaker
class CodeMaker
  COLORS = %w[Red Green Blue Yellow Orange Purple].freeze

  def generate_code
    COLORS.sample(4)
  end
end

# class CodeBreaker
class CodeBreaker
  def make_guess
    puts 'Enter your guess (4 colors separated by spaces):'
    gets.chomp.split
  end
end

# class Feedback
class Feedback
  def evaluate(guess, secret_code)
    correct_positions = guess.zip(secret_code).count { |g, s| g == s }
    correct_colors = (guess & secret_code).size - correct_positions

    {
      correct: correct_positions == 4,
      feedback: "#{correct_positions} correct position(s), #{correct_colors} correct color(s)"
    }
  end
end

# class ComputerGuesser
class ComputerGuesser
  COLORS = %w[Red Green Blue Yellow Orange Purple].freeze

  def initialize
    @possible_codes = COLORS.repeated_permutation(4).to_a
  end

  def make_guess
    @last_guess = @possible_codes.sample
  end

  def update_possible_codes(guess, feedback)
    @possible_codes.select! do |code|
      Feedback.new.evaluate(guess, code)[:feedback] == feedback
    end
  end
end

game = Mastermind.new
game.play
