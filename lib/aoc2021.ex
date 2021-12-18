defmodule Aoc2021 do
  @moduledoc """
  Documentation for `Aoc2021`.
  """
  def input(filename) do
    {:ok, file} = File.read("lib/input/" <> filename <> ".txt")
    file
  end

  def input_to_list(input) do
    input
    |> String.split(",")
    |> Stream.map(&String.to_integer(&1))
    |> Enum.to_list()

    # |> IO.inspect(label: "input list")
  end

  def input_lines_to_list(input) do
    input
    |> String.split(~r/\n/, trim: true)

    # |> IO.inspect(label: "input list")
  end
end
