require 'minitest/autorun'

# unneccesary monkey patch, but unless empty? was bothering me
# could also just use activesupport
class String
  def present?
    !self.empty?
  end
end

class TopThreeElfCalories
  def initialize(food_list:)
    @food_list = food_list
  end

  def execute
    total_counts = []
    elf_count = 0

    @food_list.each_line do |line|
      stripped_line = line.strip

      if stripped_line.present?
        elf_count += stripped_line.to_i
      else
        total_counts << elf_count
        elf_count = 0
      end
    end

    total_counts.max(3).sum
  end

  class TopThreeElfCaloriesTest < Minitest::Test
    def test_elf_calories_returns_max_sum_of_nested_calories
      food_list = "5\n\n10\n\n20\n\n20\n\n" # 5 shouldn't be added because it's lowest

      elf_calories = TopThreeElfCalories.new(food_list: food_list)
      assert_equal(elf_calories.execute, 50)
    end
  end
end

input_data = File.read(File.join(__dir__, "input.dat"))

elf_calories = TopThreeElfCalories.new(food_list: input_data)
puts "The max calories an elf is carrying is #{elf_calories.execute}."
