defmodule Aoc2021 do
  @moduledoc """
  Documentation for `Aoc2021`.
  """
  def input(filename) do
      {:ok, file} = File.read("lib/input/"<>filename<>".txt")
      file
  end
  
  def day6() do 
    input = input_to_list(Aoc2021.input("day6"))
    
    input
    |> run_gen(80)
    |> Enum.count
    |> IO.inspect(label: "Part 1")
    
    # 256GB memory can't handle 256 generations using this process, Tried on EC2 c6i.metal (128 CPUs & 256GB) 
    # Took over 50 min and used the entire 256GB of RAM with still no result so an optimization is in order
    # input
    # |> run_gen(256)
    # |> Enum.count
    # |> IO.inspect(label: "Part 2")
    
    
    
  end
  
  
  
  def input_to_list(input) do
    input
    |> String.split(",")
    |> Stream.map(&String.to_integer(&1))
    |> Enum.to_list()
    #|> IO.inspect(label: "input list")
  end
  
  def dec_fish(input) do
    input
    |> Enum.map(fn fish_age -> fish_age - 1 end)
  end
  
  def add_fish(input) do
    new_fish = Enum.reduce(input, [], fn fish, output -> if fish == -1, do: [8] ++ output, else: output end)

    input ++ new_fish  
  end
  
  def flip_to_new_fish(input) do
    input
    |> Enum.map(fn fish_age -> if fish_age == -1, do: 6, else: fish_age end)
  end
  
  def run_gen(input, gen) do
    Enum.reduce(1..gen, input, fn _gen, input -> input 
                                |> dec_fish
                                |> add_fish
                                |> flip_to_new_fish
                                end)
                                
  end
  

end
