"day2.in"
|> File.stream!()
|> Enum.map(& &1)
|> Enum.reduce(0, fn 
  "A X" <> _, score -> score + 1 + 3 # rock rock
  "A Y" <> _, score -> score + 2 + 6 # rock paper
  "A Z" <> _, score -> score + 3 + 0 # rock scissors
  "B X" <> _, score -> score + 1 + 0 # paper rock
  "B Y" <> _, score -> score + 2 + 3 # paper paper
  "B Z" <> _, score -> score + 3 + 6 # paper scissors
  "C X" <> _, score -> score + 1 + 6 # scissors rock
  "C Y" <> _, score -> score + 2 + 0 # scissors paper
  "C Z" <> _, score -> score + 3 + 3 # scissors scissors
  _, score -> score
end)
|> IO.inspect
