import Graphics.UI.Gtk
import Player
import Position
import OxoLogic
import Data.List

data GridCell = GridCell Cell Button

main :: IO ()
main = do
  initGUI
  window  <- windowNew
  set window [windowTitle := "Noughts and Crosses", windowDefaultWidth := 150,
    windowDefaultHeight := 100, containerBorderWidth := 20,
    windowWindowPosition := WinPosCenter]
  player <- labelNew (Just "Player O")
  grid <- tableNew 5 3 True
  tableAttach grid player 0 3 3 4 [Expand, Fill] [Expand, Fill] 0 10
  gridCells <- setupGrid grid generateCells []
  setCellActions gridCells gridCells player
  newGame <- buttonNewWithLabel "New Game"
  on newGame buttonActivated $ do
    mainQuit
    main
  tableAttachDefaults grid newGame 0 3 4 5
  containerAdd window grid
  onDestroy window mainQuit
  widgetShowAll window
  mainGUI

setupGrid :: Table -> [Cell] -> [GridCell] -> IO [GridCell]
setupGrid _ [] cells = return cells
setupGrid grid (cell : rest) newCells = do
  button <- buttonNew
  let (Cell (Pos row col) _) = cell
  tableAttachDefaults grid button (col - 1) col (row - 1) row
  setupGrid grid rest (newCells ++ [GridCell cell button])

setCellActions :: [GridCell] -> [GridCell] -> Label -> IO()
setCellActions [] _ _ = return()
setCellActions ((GridCell cell button) : rest) cells player = do
  on button buttonActivated (cellAction (GridCell cell button) cells player)
  setCellActions rest cells player

cellAction :: GridCell -> [GridCell] -> Label -> IO()
cellAction (GridCell (Cell pos _) button) cells player = do
  buttonLabel <- buttonGetLabel button
  if isTaken buttonLabel then return()
    else do
      pString <- labelGetText player
      if stripPrefix "Winner: " pString /= Nothing then return()
        else do
          let p = readPlayerString pString
          buttonSetLabel button (show p)
          cellList <- rebuildCellList cells [] 
          if checkWinner (Cell pos p) cellList then
            labelSetText player ("Winner: " ++ (showPlayer p))
            else if gameOver cellList then
              labelSetText player ("Game over")
              else
                labelSetText player (showPlayer (getOther p))

isTaken :: String -> Bool
isTaken "X" = True
isTaken "O" = True
isTaken  _  = False

rebuildCellList :: [GridCell] -> [Cell] -> IO [Cell]
rebuildCellList [] cells = return cells
rebuildCellList ((GridCell (Cell pos player) b) : rest) cells = do
  buttonLabel <- buttonGetLabel b
  rebuildCellList rest (cells ++ [Cell pos (readPlayerString buttonLabel)])

getListIndex :: GridCell -> Int
getListIndex (GridCell (Cell (Pos row column) _) _) =
  3 * (row - 1) + (column - 1)