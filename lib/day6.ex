defmodule Aoc2021.Day6 do
  @moduledoc """
  --- Day 6: Lanternfish ---
  The sea floor is getting steeper. Maybe the sleigh keys got carried this way?

  A massive school of glowing lanternfish swims past. They must spawn quickly to reach such large numbers - maybe exponentially quickly? You should model their growth rate to be sure.

  Although you know nothing about this specific species of lanternfish, you make some guesses about their attributes. Surely, each lanternfish creates a new lanternfish once every 7 days.

  However, this process isn't necessarily synchronized between every lanternfish - one lanternfish might have 2 days left until it creates another lanternfish, while another might have 4. So, you can model each fish as a single number that represents the number of days until it creates a new lanternfish.

  Furthermore, you reason, a new lanternfish would surely need slightly longer before it's capable of producing more lanternfish: two more days for its first cycle.

  So, suppose you have a lanternfish with an internal timer value of 3:

  After one day, its internal timer would become 2.
  After another day, its internal timer would become 1.
  After another day, its internal timer would become 0.
  After another day, its internal timer would reset to 6, and it would create a new lanternfish with an internal timer of 8.
  After another day, the first lanternfish would have an internal timer of 5, and the second lanternfish would have an internal timer of 7.
  A lanternfish that creates a new fish resets its timer to 6, not 7 (because 0 is included as a valid timer value). The new lanternfish starts with an internal timer of 8 and does not start counting down until the next day.

  Realizing what you're trying to do, the submarine automatically produces a list of the ages of several hundred nearby lanternfish (your puzzle input). For example, suppose you were given the following list:

  3,4,3,1,2
  This list means that the first fish has an internal timer of 3, the second fish has an internal timer of 4, and so on until the fifth fish, which has an internal timer of 2. Simulating these fish over several days would proceed as follows:

  Initial state: 3,4,3,1,2
  After  1 day:  2,3,2,0,1
  After  2 days: 1,2,1,6,0,8
  After  3 days: 0,1,0,5,6,7,8
  After  4 days: 6,0,6,4,5,6,7,8,8
  After  5 days: 5,6,5,3,4,5,6,7,7,8
  After  6 days: 4,5,4,2,3,4,5,6,6,7
  After  7 days: 3,4,3,1,2,3,4,5,5,6
  After  8 days: 2,3,2,0,1,2,3,4,4,5
  After  9 days: 1,2,1,6,0,1,2,3,3,4,8
  After 10 days: 0,1,0,5,6,0,1,2,2,3,7,8
  After 11 days: 6,0,6,4,5,6,0,1,1,2,6,7,8,8,8
  After 12 days: 5,6,5,3,4,5,6,0,0,1,5,6,7,7,7,8,8
  After 13 days: 4,5,4,2,3,4,5,6,6,0,4,5,6,6,6,7,7,8,8
  After 14 days: 3,4,3,1,2,3,4,5,5,6,3,4,5,5,5,6,6,7,7,8
  After 15 days: 2,3,2,0,1,2,3,4,4,5,2,3,4,4,4,5,5,6,6,7
  After 16 days: 1,2,1,6,0,1,2,3,3,4,1,2,3,3,3,4,4,5,5,6,8
  After 17 days: 0,1,0,5,6,0,1,2,2,3,0,1,2,2,2,3,3,4,4,5,7,8
  After 18 days: 6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8
  Each day, a 0 becomes a 6 and adds a new 8 to the end of the list, while each other number decreases by 1 if it was present at the start of the day.

  In this example, after 18 days, there are a total of 26 fish. After 80 days, there would be a total of 5934.

  Find a way to simulate lanternfish. How many lanternfish would there be after 80 days?

  Your puzzle answer was 351188.

  --- Part Two ---
  Suppose the lanternfish live forever and have unlimited food and space. Would they take over the entire ocean?

  After 256 days in the example above, there would be a total of 26984457539 lanternfish!

  How many lanternfish would there be after 256 days?

  Your puzzle answer was 1595779846729.

  Both parts of this puzzle are complete! They provide two gold stars: **
  """

  def day6() do
    input = input_to_list(Aoc2021.input("day6"))

    input
    |> run_gen(80)
    |> Enum.count()
    |> IO.inspect(label: "Part 1")

    # 256GB memory can't handle 256 generations using this process, Tried on EC2 c6i.metal (128 CPUs & 256GB) 
    # Took over 50 min and used the entire 256GB of RAM with still no result so an optimization is in order
    # input
    # |> run_gen(256)
    # |> Enum.count
    # |> IO.inspect(label: "Part 2")

    input
    |> make_hash
    |> run_gen_hash(256)
    |> get_sum
    |> IO.inspect(label: "Part 2")
  end

  def input_to_list(input) do
    input
    |> String.split(",")
    |> Stream.map(&String.to_integer(&1))
    |> Enum.to_list()

    # |> IO.inspect(label: "input list")
  end

  def dec_fish(input) do
    input
    |> Enum.map(fn fish_age -> fish_age - 1 end)
  end

  def add_fish(input) do
    new_fish =
      Enum.reduce(input, [], fn fish, output -> if fish == -1, do: [8] ++ output, else: output end)

    input ++ new_fish
  end

  def flip_to_new_fish(input) do
    input
    |> Enum.map(fn fish_age -> if fish_age == -1, do: 6, else: fish_age end)
  end

  def run_gen(input, gen) do
    Enum.reduce(1..gen, input, fn _gen, input ->
      input
      |> dec_fish
      |> add_fish
      |> flip_to_new_fish
    end)
  end

  def make_hash(input) do
    hash = %{"0": 0, "1": 0, "2": 0, "3": 0, "4": 0, "5": 0, "6": 0, "7": 0, "8": 0}

    Enum.reduce(input, hash, fn fish, hash ->
      key = String.to_atom(Integer.to_string(fish))
      {_, result} = Map.get_and_update(hash, key, fn current -> {current, current + 1} end)
      result
    end)
  end

  def next_gen(hash) do
    nextgen =
      hash
      |> Enum.reduce(%{}, fn fish_group, new_hash ->
        case fish_group do
          {:"8", count} ->
            Map.update(new_hash, :"7", count, fn count -> count end)

          {:"7", count} ->
            Map.update(new_hash, :"6", count, fn count -> count end)

          {:"6", count} ->
            Map.update(new_hash, :"5", count, fn count -> count end)

          {:"5", count} ->
            Map.update(new_hash, :"4", count, fn count -> count end)

          {:"4", count} ->
            Map.update(new_hash, :"3", count, fn count -> count end)

          {:"3", count} ->
            Map.update(new_hash, :"2", count, fn count -> count end)

          {:"2", count} ->
            Map.update(new_hash, :"1", count, fn count -> count end)

          {:"1", count} ->
            Map.update(new_hash, :"0", count, fn count -> count end)

          {:"0", count} ->
            new_hash = Map.update(new_hash, :"8", count, fn count -> count end)
            current_plus_count = Map.fetch!(hash, :"7") + count

            Map.update(new_hash, :"6", current_plus_count, fn current_plus_count ->
              current_plus_count
            end)
        end
      end)
      |> IO.inspect()
  end

  def run_gen_hash(hash, 0), do: hash

  def run_gen_hash(hash, count) do
    run_gen_hash(next_gen(hash), count - 1)
  end

  def get_sum(hash) do
    Enum.reduce(hash, 0, fn fish_group = {_, count}, sum -> sum + count end)
  end
end
