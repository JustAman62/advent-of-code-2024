defmodule AdventOfCode.Day04 do
  def part1(args) do
    grid =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.graphemes(&1) |> Enum.with_index()))

    height = length(grid)
    width = Enum.at(grid, 0) |> length()

    grid =
      grid
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, row} ->
        Enum.map(line, fn {char, col} -> %{{row, col} => char} end)
      end)
      |> Enum.reduce(&Map.merge/2)

    Enum.flat_map(0..height, fn row ->
      Enum.map(0..width, &count_xmas_occurances(grid, row, &1))
    end)
    |> IO.inspect()
    |> Enum.sum()
    |> IO.inspect()
  end

  defp count_xmas_occurances(grid, row, col) do
    is_xmas_right(grid, row, col) +
      is_xmas_left(grid, row, col) +
      is_xmas_up(grid, row, col) +
      is_xmas_down(grid, row, col) +
      is_xmas_up_right(grid, row, col) +
      is_xmas_down_right(grid, row, col) +
      is_xmas_down_left(grid, row, col) +
      is_xmas_up_left(grid, row, col)
  end

  defp is_xmas_right(grid, row, col) do
    if Map.get(grid, {row, col}) == "X" &&
         Map.get(grid, {row, col + 1}) == "M" &&
         Map.get(grid, {row, col + 2}) == "A" &&
         Map.get(grid, {row, col + 3}) == "S" do
      1
    else
      0
    end
  end

  defp is_xmas_left(grid, row, col) do
    if Map.get(grid, {row, col}) == "X" &&
         Map.get(grid, {row, col - 1}) == "M" &&
         Map.get(grid, {row, col - 2}) == "A" &&
         Map.get(grid, {row, col - 3}) == "S" do
      1
    else
      0
    end
  end

  defp is_xmas_up(grid, row, col) do
    if Map.get(grid, {row, col}) == "X" &&
         Map.get(grid, {row + 1, col}) == "M" &&
         Map.get(grid, {row + 2, col}) == "A" &&
         Map.get(grid, {row + 3, col}) == "S" do
      1
    else
      0
    end
  end

  defp is_xmas_down(grid, row, col) do
    if Map.get(grid, {row, col}) == "X" &&
         Map.get(grid, {row - 1, col}) == "M" &&
         Map.get(grid, {row - 2, col}) == "A" &&
         Map.get(grid, {row - 3, col}) == "S" do
      1
    else
      0
    end
  end

  defp is_xmas_up_right(grid, row, col) do
    if Map.get(grid, {row, col}) == "X" &&
         Map.get(grid, {row + 1, col + 1}) == "M" &&
         Map.get(grid, {row + 2, col + 2}) == "A" &&
         Map.get(grid, {row + 3, col + 3}) == "S" do
      1
    else
      0
    end
  end

  defp is_xmas_down_right(grid, row, col) do
    if Map.get(grid, {row, col}) == "X" &&
         Map.get(grid, {row - 1, col + 1}) == "M" &&
         Map.get(grid, {row - 2, col + 2}) == "A" &&
         Map.get(grid, {row - 3, col + 3}) == "S" do
      1
    else
      0
    end
  end

  defp is_xmas_down_left(grid, row, col) do
    if Map.get(grid, {row, col}) == "X" &&
         Map.get(grid, {row - 1, col - 1}) == "M" &&
         Map.get(grid, {row - 2, col - 2}) == "A" &&
         Map.get(grid, {row - 3, col - 3}) == "S" do
      1
    else
      0
    end
  end

  defp is_xmas_up_left(grid, row, col) do
    if Map.get(grid, {row, col}) == "X" &&
         Map.get(grid, {row + 1, col - 1}) == "M" &&
         Map.get(grid, {row + 2, col - 2}) == "A" &&
         Map.get(grid, {row + 3, col - 3}) == "S" do
      1
    else
      0
    end
  end

  def part2(args) do
    grid =
      args
      |> String.split("\n", trim: true)
      |> Enum.map(&(String.graphemes(&1) |> Enum.with_index()))

    height = length(grid)
    width = Enum.at(grid, 0) |> length()

    grid =
      grid
      |> Enum.with_index()
      |> Enum.flat_map(fn {line, row} ->
        Enum.map(line, fn {char, col} -> %{{row, col} => char} end)
      end)
      |> Enum.reduce(&Map.merge/2)

    Enum.flat_map(0..height, fn row ->
      Enum.map(0..width, &count_mas_occurances(grid, row, &1))
    end)
    |> IO.inspect()
    |> Enum.sum()
    |> IO.inspect()
  end

  defp count_mas_occurances(grid, row, col) do
    if is_down_left_top_right(grid, row, col) && is_up_left_down_right(grid, row, col) do
      1
    else
      0
    end
  end

  defp is_down_left_top_right(grid, row, col) do
    Map.get(grid, {row, col}) == "A" &&
      ((Map.get(grid, {row - 1, col - 1}) == "S" && Map.get(grid, {row + 1, col + 1}) == "M") ||
         (Map.get(grid, {row - 1, col - 1}) == "M" && Map.get(grid, {row + 1, col + 1}) == "S"))
  end

  defp is_up_left_down_right(grid, row, col) do
    Map.get(grid, {row, col}) == "A" &&
      ((Map.get(grid, {row + 1, col - 1}) == "S" && Map.get(grid, {row - 1, col + 1}) == "M") ||
         (Map.get(grid, {row + 1, col - 1}) == "M" && Map.get(grid, {row - 1, col + 1}) == "S"))
  end
end
