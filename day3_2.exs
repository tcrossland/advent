defmodule Foo do
  def to_chars(line) do
    line
    |> String.trim()
    |> String.to_charlist()
  end

  def common([_, _, _] = list) do
    list
    |> Enum.reduce(fn i, acc -> MapSet.new(i) |> MapSet.intersection(MapSet.new(acc)) end)
    |> Enum.at(0)
  end

  def common(line) do
    chars = to_chars(line)
    {left, right} = Enum.split(chars, div(length(chars), 2))
    MapSet.new(left) |> MapSet.intersection(MapSet.new(right))
  end

  def value(c) when c >= ?a and c <= ?z, do: 1 + c - ?a
  def value(c) when c >= ?A and c <= ?Z, do: 27 + c - ?A
end

"day3.in"
|> File.stream!()
|> Stream.map(&Foo.to_chars/1)
|> Stream.chunk_every(3)
|> Stream.map(&Foo.common/1)
|> Stream.map(&Foo.value/1)
|> Enum.sum()
|> IO.inspect
