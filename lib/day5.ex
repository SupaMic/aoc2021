defmodule Aoc2021.Day5 do
  @moduledoc """
  --- Day 5: Hydrothermal Venture ---
    You come across a field of hydrothermal vents on the ocean floor! These vents constantly produce large, opaque clouds, so it would be best to avoid them if possible.
    
    They tend to form in lines; the submarine helpfully produces a list of nearby lines of vents (your puzzle input) for you to review. For example:
    
    0,9 -> 5,9
    8,0 -> 0,8
    9,4 -> 3,4
    2,2 -> 2,1
    7,0 -> 7,4
    6,4 -> 2,0
    0,9 -> 2,9
    3,4 -> 1,4
    0,0 -> 8,8
    5,5 -> 8,2
    Each line of vents is given as a line segment in the format x1,y1 -> x2,y2 where x1,y1 are the coordinates of one end the line segment and x2,y2 are the coordinates of the other end. These line segments include the points at both ends. In other words:
    
    An entry like 1,1 -> 1,3 covers points 1,1, 1,2, and 1,3.
    An entry like 9,7 -> 7,7 covers points 9,7, 8,7, and 7,7.
    For now, only consider horizontal and vertical lines: lines where either x1 = x2 or y1 = y2.
    
    So, the horizontal and vertical lines from the above list would produce the following diagram:
    
    .......1..
    ..1....1..
    ..1....1..
    .......1..
    .112111211
    ..........
    ..........
    ..........
    ..........
    222111....
    In this diagram, the top left corner is 0,0 and the bottom right corner is 9,9. Each position is shown as the number of lines which cover that point or . if no line covers that point. The top-left pair of 1s, for example, comes from 2,2 -> 2,1; the very bottom row is formed by the overlapping lines 0,9 -> 5,9 and 0,9 -> 2,9.
    
    To avoid the most dangerous areas, you need to determine the number of points where at least two lines overlap. In the above example, this is anywhere in the diagram with a 2 or larger - a total of 5 points.
    
    Consider only horizontal and vertical lines. At how many points do at least two lines overlap?
    
    Your puzzle answer was 5698.
    
    --- Part Two ---
    Unfortunately, considering only horizontal and vertical lines doesn't give you the full picture; you need to also consider diagonal lines.
    
    Because of the limits of the hydrothermal vent mapping system, the lines in your list will only ever be horizontal, vertical, or a diagonal line at exactly 45 degrees. In other words:
    
    An entry like 1,1 -> 3,3 covers points 1,1, 2,2, and 3,3.
    An entry like 9,7 -> 7,9 covers points 9,7, 8,8, and 7,9.
    Considering all lines from the above example would now produce the following diagram:
    
    1.1....11.
    .111...2..
    ..2.1.111.
    ...1.2.2..
    .112313211
    ...1.2....
    ..1...1...
    .1.....1..
    1.......1.
    222111....
    You still need to determine the number of points where at least two lines overlap. In the above example, this is still anywhere in the diagram with a 2 or larger - now a total of 12 points.
    
    Consider all of the lines. At how many points do at least two lines overlap?
    
    Your puzzle answer was 15463.
    
    Both parts of this puzzle are complete! They provide two gold stars: **
  """

  def day5() do
    g_max = get_grid_max(Aoc2021.input("day5"))

    grid = make_grid(g_max)

    danger_count =
      populate_danger(grid, Aoc2021.input("day5"))
      |> Map.to_list()
      |> Enum.reduce(0, fn {{_x, _y}, danger}, count ->
        if danger >= 2 do
          count + 1
        else
          count
        end
      end)
      |> IO.inspect(label: "danger_count")
  end

  def get_grid_max(input) do
    max =
      input
      |> String.split(~r/\n/, trim: true)
      |> Enum.map(fn line ->
        [a, b, c, d] = line |> String.split(~r/\,| -> /, trim: true)
      end)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce(0, fn cur, acc -> max(cur, acc) end)
  end

  def make_grid(size) do
    grid = for x <- 0..size, y <- 0..size, into: %{}, do: {{x, y}, 0}
  end

  def inc_coord(grid, {_x, _y} = coord) do
    {_, new_grid} = Map.get_and_update(grid, coord, fn count -> {count, count + 1} end)
    new_grid
  end

  def inc_line(grid, [{x1, y1}, {x2, y2}]) do
    cond do
      x1 == x2 ->
        Enum.reduce(y1..y2, grid, fn y, grid -> inc_coord(grid, {x1, y}) end)

      y1 == y2 ->
        Enum.reduce(x1..x2, grid, fn x, grid -> inc_coord(grid, {x, y1}) end)

      x1 < x2 || y1 > y2 || x1 > x2 || y1 < y2 ->
        inc_diag_line(grid, [{x1, y1}, {x2, y2}])

      true ->
        IO.inspect([{x1, y1}, {x2, y2}], label: "not found")
        grid
    end
  end

  def inc_diag_line(grid, [{x1, y1}, {x2, y2}]) do
    steps = Enum.count(x1..x2)

    cond do
      x1 < x2 && y1 < y2 ->
        Enum.reduce(0..(steps - 1), grid, fn step, grid ->
          inc_coord(grid, {x1 + step, y1 + step})
        end)

      x1 < x2 && y1 > y2 ->
        Enum.reduce(0..(steps - 1), grid, fn step, grid ->
          inc_coord(grid, {x1 + step, y1 - step})
        end)

      x1 > x2 && y1 < y2 ->
        Enum.reduce(0..(steps - 1), grid, fn step, grid ->
          inc_coord(grid, {x1 - step, y1 + step})
        end)

      x1 > x2 && y1 > y2 ->
        Enum.reduce(0..(steps - 1), grid, fn step, grid ->
          inc_coord(grid, {x1 - step, y1 - step})
        end)
    end
  end

  def populate_danger(grid, input) do
    input
    |> String.split(~r/\n/, trim: true)
    |> Enum.map(fn line ->
      [x1, y1, x2, y2] = line |> String.split(~r/\,| -> /, trim: true)
      [{to_int(x1), to_int(y1)}, {to_int(x2), to_int(y2)}]
    end)
    |> Enum.reduce(grid, fn coords, grid -> inc_line(grid, coords) end)
  end

  def to_int(str) do
    String.to_integer(str)
  end

  def get_c(grid, {x, y} = _coord) do
    case Map.fetch(grid, {x, y}) do
      {:ok, val} -> val
      {:error, _} -> :error
    end
  end
end
