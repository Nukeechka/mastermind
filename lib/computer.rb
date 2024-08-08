# frozen_string_literal: true

require './lib/player'
# class Computer
class Computer < Player
  def create_secret_code(colors)
    code = []
    4.times do
      code.push(colors.sample)
    end
    code
  end
end
