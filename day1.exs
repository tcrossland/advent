"day1.in"
|> File.stream!()
|> Enum.map(&Integer.parse/1)
|> Enum.reduce([0], fn
  {c, _}, [total | rest] -> [total + c | rest]
  :error, acc -> [0 | acc]
end)
|> Enum.reverse
|> Enum.with_index(1)
|> Enum.max_by(fn {total, n} -> total end)
|> IO.inspect
