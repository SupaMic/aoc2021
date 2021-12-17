defmodule Aoc2021Test.D7 do
  use ExUnit.Case
  import Aoc2021
  import Aoc2021.Day7
  doctest Aoc2021
  @moduletag :day7

  setup do
    {:ok, example: "16,1,2,0,4,2,7,1,2,14"}
  end

  test "input process", context do
    input = input_to_list(context[:example])
    assert input == [16, 1, 2, 0, 4, 2, 7, 1, 2, 14]
  end

  test "align row fuel count", context do
    input = Aoc2021.input_to_list(context[:example])

    count = fuel_align_to_row(input, 1)
    assert count == 41
  end

  test "best_row", context do
    input = Aoc2021.input_to_list(context[:example])

    assert best_row(input) == 37
  end

  test "steps sum" do
    assert steps_sum(3) == 6
  end

  test "increasing fuels steps align row fuel count", context do
    input = Aoc2021.input_to_list(context[:example])

    count = steps_fuel_align_to_row(input, 2)
    assert count == 206
  end

  test "diminishing returns best_row", context do
    input = Aoc2021.input_to_list(context[:example])

    assert best_row(input, :steps) == 168
  end
end
