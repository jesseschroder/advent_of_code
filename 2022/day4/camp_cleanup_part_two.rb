require 'minitest/autorun'

class CampCleanup
  def initialize(input:)
    @clean_up_list = input
  end

  def execute
    total_count = 0

    @clean_up_list.each_line do |line|
      first_elf, second_elf = line.strip.split(',')

      first_elf = first_elf.split('-')
      second_elf = second_elf.split('-')

      first_range = (first_elf[0]..first_elf[-1])
      second_range = (second_elf[0]..second_elf[-1])

      unless (first_range.to_a & second_range.to_a).empty? # with activesupport use if .. present?
        total_count += 1
      end
    end

    total_count
  end

  class CampCleanupTest < Minitest::Test
    def test_camp_cleanup_returns_expected_total
      input = <<~HEREDOC
        2-4,6-8
        2-3,4-5
        5-7,7-9
        2-8,3-7
        6-6,4-6
        2-6,4-8
      HEREDOC
      camp_cleanup = CampCleanup.new(input:)


      assert_equal 4, camp_cleanup.execute
    end
  end
end

input = File.read(File.join(__dir__, 'input.dat'))
camp_cleanup = CampCleanup.new(input:)

puts "There are #{camp_cleanup.execute} ranges that are contained in their pair"
