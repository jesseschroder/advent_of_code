require 'minitest/autorun'

class RucksackReorganization
  UPCASE_CHAR_CODE_OFFSET = 38
  DOWNCASE_CHAR_CODE_OFFSET = 96


  def initialize(rucksack_list:)
    @rucksack_list = rucksack_list
  end

  def execute
    total_priority = 0
    single_rucksacks = @rucksack_list.split("\n")
    grouped_rucksacks = single_rucksacks.each_slice(3).to_a

    grouped_rucksacks.each do |group|
      unique_value = unique_group_value(group)

      if unique_value == unique_value.upcase
        total_priority += unique_value.ord - UPCASE_CHAR_CODE_OFFSET
      else
        total_priority += unique_value.ord - DOWNCASE_CHAR_CODE_OFFSET
      end
    end

    total_priority
  end

  private

  def unique_group_value(group)
    (group[0].split('') & group[1].split('') & group[2].split('')).first
  end

  class RucksackReorganizationTest < Minitest::Test
    def test_rucksack_prioritization_sum
      rucksack_list = <<~HEREDOC
        vJrwpWtwJgWrhcsFMMfFFhFp
        jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
        PmmdzqPrVvPwwTWBwg
        wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
        ttgJtRGJQctTZtZT
        CrZsJsPPZsGzwwsLwLmpwMDw
      HEREDOC


      rucksack_reorg = RucksackReorganization.new(rucksack_list:)

      assert rucksack_reorg.execute, 70 # example solution
    end
  end
end

rucksack_list = File.read(File.join(__dir__, 'input.dat'))
rucksack_reorg = RucksackReorganization.new(rucksack_list:)

puts "The total priority is #{rucksack_reorg.execute}"
