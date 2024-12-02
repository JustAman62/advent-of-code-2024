defmodule AdventOfCode.Day01 do
  def part1(args) do
    # Parse the lines and enter the numbers in to two lists
    {left, right} =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> line |> String.split(" ", trim: true) |> List.to_tuple() end)
      |> Enum.unzip()

    left = left |> to_sorted_ints()
    right = right |> to_sorted_ints()

    Enum.zip_reduce(left, right, 0, fn left, right, acc -> acc + abs(left - right) end)
  end

  defp to_sorted_ints(list) do
    list |> Enum.map(fn x -> String.to_integer(x) end) |> Enum.sort()
  end

  def part2(args) do
    # Parse the lines and enter the numbers in to two lists
    {left, right} =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(fn line -> line |> String.split(" ", trim: true) |> List.to_tuple() end)
      |> Enum.unzip()

    left = left |> to_sorted_ints()

    right =
      right
      |> to_sorted_ints()
      |> Enum.group_by(& &1)
      |> Enum.map(fn x -> {Kernel.elem(x, 0), Kernel.elem(x, 1) |> length()} end)
      |> Map.new()

    Enum.reduce(left, 0, fn left, acc -> acc + (left * Map.get(right, left, 0)) end)
  end
end
