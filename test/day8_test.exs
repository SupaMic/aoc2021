defmodule Aoc2021Test.D8 do
  use ExUnit.Case
  import Aoc2021
  import Aoc2021.Day8
  doctest Aoc2021
  @moduletag :day8

  setup do
    {:ok,
     example:
       "be cfbegad cbdgef fgaecd cgeb fdcge agebfd fecdb fabcd edb | fdgacbe cefdb cefbgd gcbe
edbfga begcd cbg gc gcadebf fbgde acbgfd abcde gfcbed gfec | fcgedb cgb dgebacf gc
fgaebd cg bdaec gdafb agbcfd gdcbef bgcad gfac gcb cdgabef | cg cg fdcagb cbg
fbegcd cbd adcefb dageb afcb bc aefdc ecdab fgdeca fcdbega | efabcd cedba gadfec cb
aecbfdg fbg gf bafeg dbefa fcge gcbea fcaegb dgceab fcbdga | gecf egdcabf bgf bfgea
fgeab ca afcebg bdacfeg cfaedg gcfdb baec bfadeg bafgc acf | gebdcfa ecba ca fadegcb
dbcfg fgd bdegcaf fgec aegbdf ecdfab fbedc dacgb gdcebf gf | cefg dcbef fcge gbcadfe
bdfegc cbegaf gecbf dfcage bdacg ed bedf ced adcbefg gebcd | ed bcgafe cdgba cbgef
egadfb cdbfeg cegd fecab cgb gbdefca cg fgcdab egfdb bfceg | gbdfcae bgc cg cgb
gcafb gcf dcaebfg ecagb gf abcdeg gaef cafbge fdbac fegbdc | fgae cfgab fg bagce"}
  end

  test "process input", context do
    input = input_lines_to_list(context[:example])

    assert List.first(get_outputs(input)) == "fdgacbe cefdb cefbgd gcbe"
  end

  test "key", context do
    input = [
      "be",
      "cfbegad",
      "cbdgef",
      "fgaecd",
      "cgeb",
      "fdcge",
      "agebfd",
      "fecdb",
      "fabcd",
      "edb",
      "fdgacbe",
      "cefdb",
      "cefbgd",
      "gcbe"
    ]

    key = make_key(input)

    assert key == %{
             eight: "abcdefg",
             five: "cdefg",
             four: "bceg",
             nine: "bcdefg",
             one: "be",
             seven: "bde",
             six: "acdefg",
             three: "bcdef",
             two: "abcdf",
             zero: "abdefg"
           }
  end

  test "decode" do
    assert decode([
             "acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab",
             "cdfeb fcadb cdfeb cdbaf"
           ]) == 5353
  end
end
