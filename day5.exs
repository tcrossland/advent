defmodule Foo do
  def clean_stack(str) do
    str
    |> String.replace(" 1   2   3   4   5   6   7   8   9 ", "123456789")
    |> String.replace("    ", " [ ]")
    |> String.replace("] [", "")
    |> String.replace("[", "")
    |> String.replace("]", "")
    |> String.to_charlist()
    |> IO.inspect(label: str)
  end

  def push(32, s), do: s
  def push(c, s), do: [c | s]

  def reduce_stack(v, '123456789'), do: Enum.map(v, &[&1])
  def reduce_stack(v, s) do
    v
    |> Enum.zip(s)
    |> Enum.map(fn {v, s} -> push(v, s) end)
  end

  def move(str, acc) do
    ["move", n, "from", from, "to", to] = String.split(str, " ")
    n = String.to_integer(n)
    {take, acc} = Map.get_and_update!(acc, from, &Enum.split(&1, n))
    length(take) == n
    Map.update!(acc, to, & (take ++ &1))
  end
end

{moves, stacks} =
  "in/day5.txt"
  |> File.stream!()
  |> Stream.map(&String.trim_trailing(&1, "\n"))
  |> Stream.reject(&(&1 == ""))
  |> Enum.split_with(&String.starts_with?(&1, "move"))

stacks =
  stacks
  |> Enum.reverse()
  |> Enum.map(&Foo.clean_stack/1)
  |> Enum.reduce(&Foo.reduce_stack/2)
  |> Enum.with_index(1)
  |> Map.new(fn {s, i} -> {"#{i}", s} end)
  |> IO.inspect()

moves
|> Enum.reduce(stacks, &Foo.move/2)
|> IO.inspect()
