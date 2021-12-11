defmodule Aoc2021Test.D5 do
  use ExUnit.Case
  doctest Aoc2021
  
  setup do
    {:ok, demo_input1: 
"0,9 -> 5,9
8,0 -> 0,8
9,4 -> 3,4
2,2 -> 2,1
7,0 -> 7,4
6,4 -> 2,0
0,9 -> 2,9
3,4 -> 1,4
0,0 -> 8,8
5,5 -> 8,2"}
  end

  test "Correct Grid Size", context do
    assert Aoc2021.Day5.get_grid_max(context[:demo_input1]) == 9
  end
  
  test "Check 0, 0 and max, max Corner", context do
    max = Aoc2021.Day5.get_grid_max(context[:demo_input1])
    grid = Aoc2021.Day5.make_grid(max)
    assert Map.fetch(grid, {0, 0}) == {:ok, 0}
    assert Map.fetch(grid, {max, max}) == {:ok, 0}
  end
  
  test "increment coord", context do
    max = Aoc2021.Day5.get_grid_max(context[:demo_input1])
    grid = Aoc2021.Day5.make_grid(max)
    assert Map.fetch(grid, {max-1, max-1}) == {:ok, 0}
    new_grid = Aoc2021.Day5.inc_coord(grid, {max-1, max-1})
    assert Map.fetch(new_grid, {max-1, max-1}) == {:ok, 1}
    new_grid = Aoc2021.Day5.inc_coord(new_grid, {max-1, max-1})
    assert Map.fetch(new_grid, {max-1, max-1}) == {:ok, 2}
    new_grid = Aoc2021.Day5.inc_coord(new_grid, {max-2, max-1})
    assert Map.fetch(new_grid, {max-2, max-1}) == {:ok, 1}
    new_grid = Aoc2021.Day5.inc_coord(new_grid, {max-3, max-1})
    assert Map.fetch(new_grid, {max-3, max-1}) == {:ok, 1}
  end
  
  test "increment a line", context do 
    max = Aoc2021.Day5.get_grid_max(context[:demo_input1])
    grid = Aoc2021.Day5.make_grid(max)
    
    coord1 = {1,1}
    coord2 = {1,3}
    assert Aoc2021.Day5.get_c(grid, coord1) == 0
    assert Aoc2021.Day5.get_c(grid, {1,2}) == 0
    assert Aoc2021.Day5.get_c(grid, coord2) == 0
    
    new_grid = Aoc2021.Day5.inc_line(grid, [coord1, coord2])
    
    assert Aoc2021.Day5.get_c(new_grid, coord1) == 1
    assert Aoc2021.Day5.get_c(new_grid, {1,2}) == 1
    assert Aoc2021.Day5.get_c(new_grid, coord2) == 1
    
    coord3 = {2,2}
    coord4 = {0,2}
    
    assert Aoc2021.Day5.get_c(new_grid, {2,2}) == 0
    assert Aoc2021.Day5.get_c(new_grid, {1,2}) == 1
    assert Aoc2021.Day5.get_c(new_grid, {0,2}) == 0
    
    newer_grid = Aoc2021.Day5.inc_line(new_grid, [coord3, coord4])
    
    assert Aoc2021.Day5.get_c(newer_grid, {2,2}) == 1
    assert Aoc2021.Day5.get_c(newer_grid, {1,2}) == 2
    assert Aoc2021.Day5.get_c(newer_grid, {0,2}) == 1
    
  end
  
  test "populate grid", context do
    max = Aoc2021.Day5.get_grid_max(context[:demo_input1])
    danger_grid = Aoc2021.Day5.make_grid(max)
    |> IO.inspect(label: "test grid")
    |> Aoc2021.Day5.populate_danger(context[:demo_input1])
    |> IO.inspect(label: "test danger grid")
    
    assert Aoc2021.Day5.get_c(danger_grid, {0,0}) == 1
    assert Aoc2021.Day5.get_c(danger_grid, {1,1}) == 1
    assert Aoc2021.Day5.get_c(danger_grid, {2,2}) == 2
    
    
  end
  
  
  
  
end
