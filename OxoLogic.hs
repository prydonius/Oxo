module OxoLogic where
import Position
import Player

data Cell = Cell Position Player
  deriving (Show, Eq)

base = 1
gridSize = 3

generateCells :: [Cell]
generateCells = createCells 1 1 []
  where
    createCells :: Int -> Int -> [Cell] -> [Cell]
    createCells row col cells =
      if row > gridSize then cells
        else if col > gridSize then createCells (row + 1) base cells
          else
            createCells row (col + 1) (cells ++ [Cell (Pos row col) None])

gameOver :: [Cell] -> Bool
gameOver cells = all cellTaken cells

cellTaken :: Cell -> Bool
cellTaken (Cell _ cellPlayer) = cellPlayer /= None

checkWinner :: Cell -> [Cell] -> Bool
checkWinner (Cell (Pos row col) player) cells =
  all (samePlayer player) (filterByRow row cells) ||
  all (samePlayer player) (filterByCol col cells) ||
  all (samePlayer player) (filterByPosDiag cells 1 []) ||
  all (samePlayer player) (filterByNegDiag cells 1 [])

samePlayer :: Player -> Cell -> Bool
samePlayer player (Cell _ cellPlayer) = player == cellPlayer

filterByRow :: Int -> [Cell] -> [Cell]
filterByRow n cells = filter (isOnRow n) cells
  where
    isOnRow n (Cell (Pos row _) _) = row == n

filterByCol :: Int -> [Cell] -> [Cell]
filterByCol n cells = filter (isOnCol n) cells
  where
    isOnCol n (Cell (Pos _ col) _) = col == n

-- index = (gridSize - 1) * row
filterByPosDiag :: [Cell] -> Int -> [Cell] -> [Cell]
filterByPosDiag cells row newCells =
  if row > gridSize then newCells
    else filterByPosDiag cells (row + 1) (newCells ++
      [cells !! ((gridSize - 1) * row)])

-- index = (gridSize + 1) * (row - 1)
filterByNegDiag :: [Cell] -> Int -> [Cell] -> [Cell]
filterByNegDiag cells row newCells =
  if row > gridSize then newCells
    else filterByNegDiag cells (row + 1) (newCells ++
      [cells !! ((gridSize + 1) * (row - 1))])
