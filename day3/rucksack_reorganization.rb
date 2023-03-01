require 'minitest/autorun'

class RucksackReorganization
  UPCASE_CHAR_CODE_OFFSET = 38
  DOWNCASE_CHAR_CODE_OFFSET = 96


  def initialize(rucksack_list:)
    @rucksack_list = rucksack_list
  end

  def execute
    total_priority = 0

    @rucksack_list.each_line do |line|
      split_line = line.strip.split('')
      first_sack, second_sack = split_line.each_slice(split_line.length / 2).to_a

      item_match = first_sack.find { |c| second_sack.include?(c) }

      # a rough scratch of a more efficient solution to above line
      #
      # first_sack.each_with_index do |c,i|
      #   if c == second_sack[i]
      #     item_match = c
      #     break
      #   end
      # end

      if item_match == item_match.upcase
        total_priority += item_match.ord - UPCASE_CHAR_CODE_OFFSET
      else
        total_priority += item_match.ord - DOWNCASE_CHAR_CODE_OFFSET
      end
    end

    total_priority
  end

  class RucksackReorganizationTest < Minitest::Test
    def test_rucksack_prioritization_sum
      rucksack_list = "vJrwpWtwJgWrhcsFMMfFFhFp\njqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL\nPmmdzqPrVvPwwTWBwg\nwMqvLMZHhHMvwLHjbvcjnnSBnvTQFn\nttgJtRGJQctTZtZT\nCrZsJsPPZsGzwwsLwLmpwMDw"
      rucksack_reorg = RucksackReorganization.new(rucksack_list:)

      assert rucksack_reorg.execute, 157 # example solution
    end
  end
end

rucksack_list = File.read(File.join(__dir__, 'input.dat'))
rucksack_reorg = RucksackReorganization.new(rucksack_list:)

puts "The total priority is #{rucksack_reorg.execute}"
