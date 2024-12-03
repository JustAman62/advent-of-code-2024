defmodule AdventOfCode.Day03 do
  def part1(args) do
    Regex.scan(~r/mul\((\d+),(\d+)\)/, args)
    |> Enum.map(fn match ->
      first = Enum.at(match, 1) |> String.to_integer()
      second = Enum.at(match, 2) |> String.to_integer()
      first * second
    end)
    |> Enum.sum()
  end

  def part2(args) do
    Regex.scan(~r/mul\((\d+),(\d+)\)|do\(\)|don't\(\)/, args)
    |> Enum.map(fn match ->
      case match do
        ["do()"] -> {:enable}
        ["don't()"] -> {:disable}
        [_, first, second] -> {:mul, String.to_integer(first) * String.to_integer(second)}
      end
    end)
    |> Enum.reduce({:enabled, 0}, fn item, {state, sum} ->
      case item do
        {:enable} -> {:enabled, sum}
        {:disable} -> {:disabled, sum}
        {:mul, _} when state == :disabled -> {:disabled, sum}
        {:mul, to_add} when state == :enabled -> {:enabled, to_add + sum}
      end
    end)
    |> Kernel.elem(1)
  end
end
