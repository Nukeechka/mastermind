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
end
