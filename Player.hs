module Player where
data Player = O | X | None
  deriving (Show, Enum, Eq)

getOther :: Player -> Player
getOther O = X
getOther X = O

readPlayerString :: String -> Player
readPlayerString "Player O"    = O
readPlayerString "Player X"    = X
readPlayerString "Player None" = None
readPlayerString "O"           = O
readPlayerString "X"           = X
readPlayerString ""            = None

showPlayer :: Player -> String
showPlayer O    = "Player O"
showPlayer X    = "Player X"
showPlayer None = ""