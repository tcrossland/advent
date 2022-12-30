defmodule Foo do
  def to_ranges(line) do
    line
    |> String.split(",", parts: 2)
    |> Enum.map(&to_range/1)
    |> overlaps?()
  end

  def to_range(str) do
    [first, last] =
      str
      |> String.split("-", parts: 2)
      |> Enum.map(&String.to_integer/1)

    {first, last}
  end

  def fully_contains?([{first1, last1}, {first2, last2}]) do
    (first1 >= first2 and last1 <= last2) or (first2 >= first1 and last2 <= last1)
  end

  def overlaps?([{first1, last1}, {first2, last2}]) do
    not (first1 > last2 or first2 > last1)
  end
end

"in/day4.txt"
|> File.stream!()
|> Stream.map(&String.trim_trailing/1)
|> Enum.map(&Foo.to_ranges/1)
|> Enum.frequencies()
|> IO.inspect()
