defmodule Foo do
  def reduce("$ cd /", %{stack: stack} = acc), do: %{acc | stack: ["/"] |> IO.inspect(label: "cd /")}
  def reduce("$ cd ..", %{stack: [_ | parents]} = acc), do: %{acc | stack: parents |> IO.inspect(label: "cd ..")}
  def reduce("$ cd " <> dir, %{stack: stack} = acc), do: %{acc | stack: [dir | stack] |> IO.inspect(label: "cd")}
  def reduce("$ ls", acc), do: acc
  def reduce("dir " <> _dir, acc), do: acc
  def reduce(other, %{stack: stack, sizes: sizes} = acc) do
    [size, fname] = String.split(other, " ", parts: 2)
    size = String.to_integer(size)
    sizes = Map.put(sizes, [fname | stack], size)
    %{acc | sizes: sizes}
  end

  def accumulate({[], size}, acc), do: acc

  def accumulate({[_ | rest] = path, size}, acc) do
    acc = Map.update(acc, path, size, & &1 + size)
    accumulate({rest, size}, acc)
  end
end

"in/day7.txt"
|> File.stream!()
|> Enum.map(&String.trim_trailing/1)
|> Enum.reduce(%{stack: [], sizes: %{}}, &Foo.reduce/2)
|> Map.get(:sizes)
|> Enum.map(fn {path, size} -> {tl(path), size} end)
|> Enum.reduce(%{}, &Foo.accumulate/2)
#|> Enum.filter(fn {_, size} -> size <= 100_000 end)
#|> Enum.reduce(0, fn {_, size}, acc -> acc + size end)
|> IO.inspect(limit: 100)
|> case do
  %{["/"] => total} = du ->
    unused = 70000000 - total
    du
    |> Enum.filter(fn {path, size} -> unused + size >= 30000000 end)
    |> Enum.min_by(fn {_, size} -> size end)
    |> IO.inspect(label: "DELETE")
end
