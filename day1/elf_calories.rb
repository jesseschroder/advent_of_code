require 'minitest/autorun'

# unneccesary monkey patch, but unless empty? was bothering me
# could also just use activesupport
class String
  def present?
    !self.empty?
  end
end

class ElfCalories
  def initialize(food_list:)
    @food_list = food_list
  end

  def execute
    high_count = 0
    elf_count = 0

    @food_list.each_line do |line|
      stripped_line = line.strip

      if stripped_line.present?
        elf_count += stripped_line.to_i
      else
        high_count = elf_count if elf_count > high_count
        elf_count = 0
      end
    end

    high_count
  end

  class ElfCaloriesTest < Minitest::Test
    def test_elf_calories_returns_max_sum_of_nested_calories
      food_list = "4035\n10596\n17891\n5278\n\n11293\n8478\n10874\n10582\n10756\n6649\n\n"

      elf_calories = ElfCalories.new(food_list: food_list)
      assert_equal(elf_calories.execute, 58632)
    end
  end
end

input_data = File.read(File.join(__dir__, "input.dat"))

elf_calories = ElfCalories.new(food_list: input_data)
puts "The max calories an elf is carrying is #{elf_calories.execute}."
