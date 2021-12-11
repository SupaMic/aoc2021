defmodule Aoc2021 do
  @moduledoc """
  Documentation for `Aoc2021`.
  """
  def input(filename) do
      {:ok, file} = File.read("lib/input/"<>filename<>".txt")
      file
  end
  
  
  
end
