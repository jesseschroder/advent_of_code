require 'minitest/autorun'

class RockPaperScissorsCalculator
  SHAPE_POINTS = {
    'A' => 1,
    'B' => 2,
    'C' => 3,
    'X' => 1,
    'Y' => 2,
    'Z' => 3,
  }

  def initialize(strategy_guide:)
    @strategy_guide = strategy_guide
  end

  def execute
    total_score = 0

    @strategy_guide.each_line do |line|
      my_shape, opponent_shape = round_shapes(line.strip)

      total_score += SHAPE_POINTS[my_shape]
      match_difference = SHAPE_POINTS[my_shape] - SHAPE_POINTS[opponent_shape]

      if match_difference == 0
        total_score += 3
      elsif match_difference == 1 || match_difference == -2 # only these results are a win, 2 and -1 are losses
        total_score += 6
      end
    end

    total_score
  end

  def round_shapes(line)
    # returns my shape and opponent shape
    [line[-1], line[0]]
  end


  class RockPaperScissorsCalculatorTest < Minitest::Test
    def test_total_calculated_score
      input_data = "A Y\nB X\nC Z\n"
      calculator = RockPaperScissorsCalculator.new(strategy_guide: input_data)

      assert_equal(calculator.execute, 15) # example solution
    end
  end
end

input_data = File.read(File.join(__dir__, 'input.dat'))
calculator = RockPaperScissorsCalculator.new(strategy_guide: input_data)

puts "The total score of this guide is #{calculator.execute}"


