defmodule Aoc2021.Day8 do
  import Aoc2021

  @moduledoc """
    --- Day 8: Seven Segment Search ---
    You barely reach the safety of the cave when the whale smashes into the cave mouth, collapsing it. Sensors indicate another exit to this cave at a much greater depth, so you have no choice but to press on.
    
    As your submarine slowly makes its way through the cave system, you notice that the four-digit seven-segment displays in your submarine are malfunctioning; they must have been damaged during the escape. You'll be in a lot of trouble without them, so you'd better figure out what's wrong.
    
    Each digit of a seven-segment display is rendered by turning on or off any of seven segments named a through g:
    
      0:      1:      2:      3:      4:
     aaaa    ....    aaaa    aaaa    ....
    b    c  .    c  .    c  .    c  b    c
    b    c  .    c  .    c  .    c  b    c
     ....    ....    dddd    dddd    dddd
    e    f  .    f  e    .  .    f  .    f
    e    f  .    f  e    .  .    f  .    f
     gggg    ....    gggg    gggg    ....
    
      5:      6:      7:      8:      9:
     aaaa    aaaa    aaaa    aaaa    aaaa
    b    .  b    .  .    c  b    c  b    c
    b    .  b    .  .    c  b    c  b    c
     dddd    dddd    ....    dddd    dddd
    .    f  e    f  .    f  e    f  .    f
    .    f  e    f  .    f  e    f  .    f
     gggg    gggg    ....    gggg    gggg
    So, to render a 1, only segments c and f would be turned on; the rest would be off. To render a 7, only segments a, c, and f would be turned on.
    
    The problem is that the signals which control the segments have been mixed up on each display. The submarine is still trying to display numbers by producing output on signal wires a through g, but those wires are connected to segments randomly. Worse, the wire/segment connections are mixed up separately for each four-digit display! (All of the digits within a display use the same connections, though.)
    
    So, you might know that only signal wires b and g are turned on, but that doesn't mean segments b and g are turned on: the only digit that uses two segments is 1, so it must mean segments c and f are meant to be on. With just that information, you still can't tell which wire (b/g) goes to which segment (c/f). For that, you'll need to collect more information.
    
    For each display, you watch the changing signals for a while, make a note of all ten unique signal patterns you see, and then write down a single four digit output value (your puzzle input). Using the signal patterns, you should be able to work out which pattern corresponds to which digit.
    
    For example, here is what you might see in a single entry in your notes:
    
    acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |
    cdfeb fcadb cdfeb cdbaf
    (The entry is wrapped here to two lines so it fits; in your notes, it will all be on a single line.)
    
    Each entry consists of ten unique signal patterns, a | delimiter, and finally the four digit output value. Within an entry, the same wire/segment connections are used (but you don't know what the connections actually are). The unique signal patterns correspond to the ten different ways the submarine tries to render a digit using the current wire/segment connections. Because 7 is the only digit that uses three segments, dab in the above example means that to render a 7, signal lines d, a, and b are on. Because 4 is the only digit that uses four segments, eafb means that to render a 4, signal lines e, a, f, and b are on.
    
    Using this information, you should be able to work out which combination of signal wires corresponds to each of the ten digits. Then, you can decode the four digit output value. Unfortunately, in the above example, all of the digits in the output value (cdfeb fcadb cdfeb cdbaf) use five segments and are more difficult to deduce.
    
    For now, focus on the easy digits. Consider this larger example:
    
    be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb |
    fdgacbe cefdb cefbgd gcbe
    edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec |
    fcgedb cgb dgebacf gc
    fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef |
    cg cg fdcagb cbg
    fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega |
    efabcd cedba gadfec cb
    aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga |
    gecf egdcabf bgf bfgea
    fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf |
    gebdcfa ecba ca fadegcb
    dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf |
    cefg dcbef fcge gbcadfe
    bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd |
    ed bcgafe cdgba cbgef
    egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg |
    gbdfcae bgc cg cgb
    gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc |
    fgae cfgab fg bagce
    Because the digits 1, 4, 7, and 8 each use a unique number of segments, you should be able to tell which combinations of signals correspond to those digits. Counting only digits in the output values (the part after | on each line), in the above example, there are 26 instances of digits that use a unique number of segments (highlighted above).
    
    In the output values, how many times do digits 1, 4, 7, or 8 appear?
    
    Your puzzle answer was 321.
    
    --- Part Two ---
    Through a little deduction, you should now be able to determine the remaining digits. Consider again the first example above:
    
    acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab |
    cdfeb fcadb cdfeb cdbaf
    After some careful analysis, the mapping between signal wires and segments only make sense in the following configuration:
    
     dddd
    e    a
    e    a
     ffff
    g    b
    g    b
     cccc
    So, the unique signal patterns would correspond to the following digits:
    
    acedgfb: 8
    cdfbe: 5
    gcdfa: 2
    fbcad: 3
    dab: 7
    cefabd: 9
    cdfgeb: 6
    eafb: 4
    cagedb: 0
    ab: 1
    Then, the four digits of the output value can be decoded:
    
    cdfeb: 5
    fcadb: 3
    cdfeb: 5
    cdbaf: 3
    Therefore, the output value for this entry is 5353.
    
    Following this same process for each entry in the second, larger example above, the output value of each entry can be determined:
    
    fdgacbe cefdb cefbgd gcbe: 8394
    fcgedb cgb dgebacf gc: 9781
    cg cg fdcagb cbg: 1197
    efabcd cedba gadfec cb: 9361
    gecf egdcabf bgf bfgea: 4873
    gebdcfa ecba ca fadegcb: 8418
    cefg dcbef fcge gbcadfe: 4548
    ed bcgafe cdgba cbgef: 1625
    gbdfcae bgc cg cgb: 8717
    fgae cfgab fg bagce: 4315
    Adding all of the output values in this larger example produces 61229.
    
    For each entry, determine all of the wire/segment connections and decode the four-digit output values. What do you get if you add up all of the output values?
    
    Your puzzle answer was 1028926.
    
    Both parts of this puzzle are complete! They provide two gold stars: **
  """

  def day8() do
    input =
      input("day8")
      |> input_lines_to_list

    _part1 =
      input
      |> get_outputs
      |> get_frequencies
      |> sum_known
      |> IO.inspect(label: "part1")

    _part2 =
      input
      |> get_pattern_and_outputs
      |> Enum.map(&decode/1)
      |> Enum.sum()
      |> IO.inspect(label: "part2")
  end

  def get_outputs(input) do
    input
    |> Enum.map(fn line ->
      {_, outs} = String.split_at(line, 61)
      outs
    end)
  end

  def get_frequencies(outputs) do
    outputs
    |> Enum.map(&String.split(&1, " "))
    |> List.flatten()
    |> Enum.frequencies_by(&String.length/1)
  end

  def sum_known(freq_map) do
    Enum.reduce(freq_map, 0, fn freq, sum ->
      case freq do
        {2, count} -> sum + count
        {3, count} -> sum + count
        {4, count} -> sum + count
        {7, count} -> sum + count
        _ -> sum
      end
    end)
  end

  # Part 2

  def get_pattern_and_outputs(input) do
    input
    |> Enum.map(fn line ->
      [pattern, outs] = String.split(line, " | ")
    end)
  end

  def decode(code = [_pattern, outs]) do
    full_set =
      code
      |> Enum.map(&String.split(&1, " "))
      |> List.flatten()

    key = make_key(full_set)

    outs
    |> String.split(" ")
    |> Enum.map(&decode_value(alphabetize(&1), key))
    |> Enum.join()
    |> String.to_integer()
  end

  def make_key(set) do
    ordered_set =
      set
      |> Enum.map(&alphabetize/1)
      |> sort_by_size

    Enum.reduce(ordered_set, %{}, fn signal, key ->
      cond do
        String.length(signal) == 2 ->
          Map.merge(key, %{one: signal})

        String.length(signal) == 3 ->
          Map.merge(key, %{seven: signal})

        String.length(signal) == 4 ->
          Map.merge(key, %{four: signal})

        String.length(signal) == 7 ->
          Map.merge(key, %{eight: signal})

        String.length(signal) == 5 ->
          cond do
            size_remaining(signal, key[:one]) == 3 && size_remaining(signal, key[:four]) == 2 ->
              Map.merge(key, %{three: signal})

            size_remaining(signal, key[:one]) == 4 && size_remaining(signal, key[:four]) == 3 ->
              Map.merge(key, %{two: signal})

            size_remaining(signal, key[:four]) == 2 && size_remaining(signal, key[:seven]) == 3 ->
              Map.merge(key, %{five: signal})
          end

        String.length(signal) == 6 ->
          cond do
            size_remaining(signal, key[:four]) == 2 && size_remaining(signal, key[:one]) == 4 ->
              Map.merge(key, %{nine: signal})

            size_remaining(signal, key[:four]) == 3 && size_remaining(signal, key[:one]) == 4 ->
              Map.merge(key, %{zero: signal})

            size_remaining(signal, key[:one]) == 5 && size_remaining(signal, key[:seven]) == 4 ->
              Map.merge(key, %{six: signal})
          end
      end

      # |> IO.inspect(label: "key building")
    end)
  end

  def size_remaining(signal, key) when key != nil do
    Enum.reject(String.graphemes(signal), &(&1 in String.graphemes(key)))
    |> length
  end

  def decode_value(code, master_key) do
    {key, value} = master_key |> Enum.find(fn {key, val} -> val == code end)

    case key do
      :one -> "1"
      :two -> "2"
      :three -> "3"
      :four -> "4"
      :five -> "5"
      :six -> "6"
      :seven -> "7"
      :eight -> "8"
      :nine -> "9"
      :zero -> "0"
    end
  end

  def alphabetize(signal) do
    signal
    |> String.split("")
    |> Enum.sort()
    |> Enum.join()
  end

  def sort_by_size(set) do
    set
    |> Enum.sort(&(byte_size(&1) <= byte_size(&2)))
  end
end
