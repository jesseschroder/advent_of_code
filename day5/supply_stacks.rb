require 'minitest/autorun'
require 'pry'

class SupplyStacks
  DEFAULT_INPUT_SETUP = [[], [], [], [], [], [], [], [], []]

  %w(J H P M S F N V).each { |x| DEFAULT_INPUT_SETUP[0].push(x) }
  %w(S R L M J D Q).each { |x| DEFAULT_INPUT_SETUP[1].push(x) }
  %w(N Q D H C S W B).each { |x| DEFAULT_INPUT_SETUP[2].push(x) }
  %w(R S C L).each { |x| DEFAULT_INPUT_SETUP[3].push(x) }
  %w(M V T P F B).each { |x| DEFAULT_INPUT_SETUP[4].push(x) }
  %w(T R Q N C).each { |x| DEFAULT_INPUT_SETUP[5].push(x) }
  %w(G V R).each { |x| DEFAULT_INPUT_SETUP[6].push(x) }
  %w(C Z S P D L R).each { |x| DEFAULT_INPUT_SETUP[7].push(x) }
  %w(D S J V G P B F).each { |x| DEFAULT_INPUT_SETUP[8].push(x) }

  TEST_INPUT_SETUP = [
    ["Z", "N"],
    ["M", "C", "D"],
    ["P"],
  ]
  def initialize(input:, setup: :default)
    @input = input
    @setup = setup == :default ? DEFAULT_INPUT_SETUP : TEST_INPUT_SETUP
  end

  def execute
    @input.each_line do |line|
      quantity, from, to = line.scan(/\d+/)

      from_index = from.to_i - 1 # index starts at 0
      to_index = to.to_i - 1 # index starts at 0

      if quantity.to_i == 38
        puts @setup[from_index].length
      end

      quantity.to_i.times { @setup[to_index] << @setup[from_index].pop }
    end

    @setup.map(&:pop).join('')
  end

  class SupplyStacksTest < Minitest::Test
    def test_moves_stacks_as_expected_sample
      setup = :test
      input = <<~HEREDOC
        move 1 from 2 to 1
        move 3 from 1 to 3
        move 2 from 2 to 1
        move 1 from 1 to 2
      HEREDOC
      supply_stacks = SupplyStacks.new(input:, setup:)

      assert_equal "CMZ", supply_stacks.execute # example problem
    end
  end
end

input = File.read(File.join(__dir__, "input.dat"))
supply_stacks = SupplyStacks.new(input:)

puts "The top of stack output is #{supply_stacks.execute}"
