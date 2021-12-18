defmodule Aoc2021.Day8 do
  import Aoc2021

  @moduledoc """

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
