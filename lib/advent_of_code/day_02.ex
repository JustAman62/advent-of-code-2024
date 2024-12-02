defmodule AdventOfCode.Day02 do
  def part1(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
    |> Enum.filter(&is_safe_level(&1))
    |> length()
  end

  @spec is_safe_level([integer()]) :: boolean()
  defp is_safe_level(level) do
    differences =
      level
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.map(fn l -> Enum.at(l, 0) - Enum.at(l, 1) end)

    Enum.all?(differences, &(&1 > 0 && &1 <= 3)) || Enum.all?(differences, &(&1 < 0 && &1 >= -3))
  end

  def part2(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn line ->
      line
      |> String.split(" ", trim: true)
      |> Enum.map(&String.to_integer(&1))
    end)
    |> Enum.filter(fn line -> generate_perms(line) |> Enum.any?(&is_safe_level(&1)) end)
    |> length()
  end

  defp generate_perms(list) do
    0..length(list) |> Enum.map(fn index -> List.delete_at(list, index) end)
  end
end
