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
  
  def make_hash(input) do
    hash = %{"0": 0, "1": 0, "2": 0, "3": 0, "4": 0, "5": 0, "6": 0, "7": 0, "8": 0}
    
    Enum.reduce(input, hash, fn fish, hash -> key = String.to_atom(Integer.to_string(fish))
                                              {_, result} = Map.get_and_update(hash, key, fn current -> {current, current + 1} end)
                                              result
                                              end)
  end
  
  def next_gen(hash) do 
    
    nextgen = hash
    |> Enum.reduce(%{}, fn fish_group, new_hash -> 
                            case fish_group do
                                    {:"8", count} -> Map.update(new_hash, :"7", count, fn count -> count end)
                                    {:"7", count} -> Map.update(new_hash, :"6", count, fn count -> count end)
                                    {:"6", count} -> Map.update(new_hash, :"5", count, fn count -> count end)
                                    {:"5", count} -> Map.update(new_hash, :"4", count, fn count -> count end)
                                    {:"4", count} -> Map.update(new_hash, :"3", count, fn count -> count end)
                                    {:"3", count} -> Map.update(new_hash, :"2", count, fn count -> count end)
                                    {:"2", count} -> Map.update(new_hash, :"1", count, fn count -> count end)
                                    {:"1", count} -> Map.update(new_hash, :"0", count, fn count -> count end)
                                    {:"0", count} -> new_hash = Map.update(new_hash, :"8", count, fn count -> count end)
                                                     current_plus_count = Map.fetch!(hash, :"7") + count
                                                     Map.update(new_hash, :"6", current_plus_count, fn current_plus_count -> current_plus_count end)
                                                          
                                                     
                                    
                            end
                        end)
    |> IO.inspect()
    
    
    
  end

  def run_gen_hash(hash, 0), do: hash
  def run_gen_hash(hash, count) do
      run_gen_hash(next_gen(hash), count-1)
  end
  
  def get_sum(hash) do
    Enum.reduce(hash, 0, fn fish_group = {_, count}, sum -> sum + count end)
  end
  
end
