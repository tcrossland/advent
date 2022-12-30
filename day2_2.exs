"day2.in"
|> File.stream!()
|> Enum.map(& &1)
|> Enum.reduce(0, fn 
  "A X" <> _, score -> score + 3 + 0 # rock scissors
  "A Y" <> _, score -> score + 1 + 3 # rock rock
  "A Z" <> _, score -> score + 2 + 6 # rock paper
  "B X" <> _, score -> score + 1 + 0 # paper rock
  "B Y" <> _, score -> score + 2 + 3 # paper paper
  "B Z" <> _, score -> score + 3 + 6 # paper scissors
  "C X" <> _, score -> score + 2 + 0 # scissors paper
  "C Y" <> _, score -> score + 3 + 3 # scissors scissors
  "C Z" <> _, score -> score + 1 + 6 # scissors rock
  _, score -> score
end)
|> IO.inspect
