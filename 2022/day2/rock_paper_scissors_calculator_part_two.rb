

require 'minitest/autorun'
require 'pry'

class RockPaperScissorsCalculator
  # This isn't my favorite solution, but it works for only 3 options
  RESULTS = {
    "A" => {
      "X" => 3,
      "Y" => 4,
      "Z" => 8,
    },
    "B" => {
      "X" => 1,
      "Y" => 5,
      "Z" => 9,
    },
    "C" => {
      "X" => 2,
      "Y" => 6,
      "Z" => 7,
    },
  }

  def initialize(strategy_guide:)
    @strategy_guide = strategy_guide
  end

  def execute
    total_score = 0

    @strategy_guide.each_line do |line|
      opponent_shape = line.strip[0]
      my_result = line.strip[-1]

      total_score += RESULTS[opponent_shape][my_result]
    end
    total_score
  end

  class RockPaperScissorsCalculatorTest < Minitest::Test
    def test_total_calculated_score
      input_data = "A Y\nB X\nC Z\n"
      calculator = RockPaperScissorsCalculator.new(strategy_guide: input_data)

      assert_equal(calculator.execute, 12) # example solution
    end
  end
end

input_data = File.read(File.join(__dir__, 'input.dat'))
calculator = RockPaperScissorsCalculator.new(strategy_guide: input_data)

puts "The total score of this guide is #{calculator.execute}"
