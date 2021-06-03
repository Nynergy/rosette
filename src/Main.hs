module Main where

import Data.List

import System.Directory
import System.Environment
import System.Exit

import Parser
import Printer
import RosetteTypes

readSystemCodesFromFile :: FilePath -> IO [SystemCode]
readSystemCodesFromFile filepath = do
  fileExists <- doesFileExist filepath
  if fileExists
    then do
      content <- readFile filepath
      return (lines content)
    else die $ "File '" ++ filepath ++ "' does not exist!"

printListOfSystems :: [System] -> IO ()
printListOfSystems systems = do
  putStrLn listString
    where
      listString = intercalate "\n" $ map (\(idx, name) -> (show idx) ++ " " ++ name) nameList
      nameList   = zip [1..] $ map (\system -> name system) systems

getUserSystemChoice :: IO String
getUserSystemChoice = do
  putStrLn "Please enter a system number:"
  choice <- getLine
  return (choice)

main :: IO ()
main = do
  args <- getArgs
  if(args == [])
    then die "USAGE: rosette [my-sector.sec]"
    else do
      systemCodes <- readSystemCodesFromFile $ head args
      let sector = convertCodesToSystems systemCodes
      putStrLn "Parsed Sector File!"
      printListOfSystems $ systems sector
      choice <- getUserSystemChoice
      let choiceIdx = (read choice :: Int) - 1
      let chosenSystem = systems sector !! choiceIdx
      putStrLn $ init $ "\n" ++ (show chosenSystem)
