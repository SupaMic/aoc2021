defmodule Aoc2021Test.D6 do
  use ExUnit.Case
  import Aoc2021
  doctest Aoc2021
  @moduletag :day6
  
  setup do
    {:ok, demo_input1: 
"3,4,3,1,2"}
  end
  
  test "input process", context do
     input = Aoc2021.input_to_list(context[:demo_input1])
     assert input == [3,4,3,1,2]
   end
   
   test "decrement fish list", context do 
    input = Aoc2021.input_to_list(context[:demo_input1])    
    new_list = dec_fish(input)
    assert new_list == [2,3,2,0,1]
    newer_list = dec_fish(new_list)
    assert newer_list == [1,2,1,-1,0]
   end
   
   test "add new fish", context do 
    input = Aoc2021.input_to_list(context[:demo_input1])
    new_list = add_fish([-1,0,1])
    assert new_list == [-1,0,1,8]
   end
   
   test "flip to new fish" do
    input = [1,2,1,-1,0]
    assert flip_to_new_fish(input) == [1,2,1,6,0]
   end
   
   test "run generation", context do
     input = Aoc2021.input_to_list(context[:demo_input1])
     
     new_fish = input
     |> run_gen(1)
     assert new_fish == [2,3,2,0,1]
     
     new_fish = input
     |> run_gen(2)
     assert new_fish == [1,2,1,6,0,8]
    
     new_fish = input
     |> run_gen(18)
     assert new_fish == [6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8]
   end
   

   
end