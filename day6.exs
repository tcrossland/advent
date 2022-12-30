"in/day6.txt"
|> File.stream!()
|> Enum.map(&String.trim_trailing/1)
|> Enum.flat_map(&String.to_charlist/1)
|> Enum.reduce_while({0, []}, fn
  c, {n, list} when n < 14 ->
    {:cont, {n + 1, [c | list]}}

  c, {n, list} ->
    case Enum.frequencies(list) |> map_size() do
      14 -> {:halt, n}
      _ -> {:cont, {n + 1, [c | Enum.take(list, 13)]}}
    end
end)
|> IO.inspect()
