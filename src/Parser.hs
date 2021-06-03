module Parser where

import Data.List.Split
import Data.Text (pack, strip, unpack)

import RosetteTypes

{- READERS -}

readBase :: Char -> Base
readBase code
  | code == 'P' = Pirate
  | code == 'C' = Consulate
  | code == 'T' = Travellers
  | code == 'R' = Research
  | code == 'N' = Naval
  | code == 'S' = Scout
  | code == 'G' = Giant

readTradeCode :: String -> TradeCode
readTradeCode code
  | code == "Ag" = Ag
  | code == "As" = As
  | code == "Ba" = Ba
  | code == "De" = De
  | code == "Fl" = Fl
  | code == "Ga" = Ga
  | code == "Hi" = Hi
  | code == "Ht" = Ht
  | code == "Ic" = Ic
  | code == "In" = In
  | code == "Lo" = Lo
  | code == "Lt" = Lt
  | code == "Na" = Na
  | code == "Ni" = Ni
  | code == "Po" = Po
  | code == "Ri" = Ri
  | code == "Va" = Va
  | code == "Wa" = Wa

readTravelZone :: String -> TravelZone
readTravelZone str
  | str == "A" = Amber
  | str == "R" = Restricted
  | otherwise  = None

{- CONVERTERS -}

-- Universal World Profiles are formatted in the following way:
-- Starport Quality (A-E or X)
-- Planet Size (0-9 or A)
-- Atmosphere Type (0-9 or A-F)
-- Hydrographics (0-9 or A)
-- Population Size (0-9 or A-C)
-- Government Type (0-9 or A-F)
-- Law Level (0-9 or A-L)
-- A single hyphen (discarded)
-- Tech Level (0-99)
convertStringToUWPInfo :: String -> UWPInfo
convertStringToUWPInfo uwp =
  UWPInfo { starport = head parseStarport
          , size = head parseSize
          , atmosphere = head parseAtmosphere
          , hydrographic = head parseHydrographic
          , population = head parsePopulation
          , government = head parseGovernment
          , law = head parseLawLevel
          , tech = parseTechLevel }
    where
      parseSingleChar str = take 1 str
      parseCharAt idx str = parseSingleChar $ drop (idx - 1) str
      parseStarport = parseCharAt 1 uwp
      parseSize = parseCharAt 2 uwp
      parseAtmosphere = parseCharAt 3 uwp
      parseHydrographic = parseCharAt 4 uwp
      parsePopulation = parseCharAt 5 uwp
      parseGovernment = parseCharAt 6 uwp
      parseLawLevel = parseCharAt 7 uwp
      parseTechLevel = read (unpack $ strip $ pack $ (parseCharAt 9 uwp) ++ (parseCharAt 10 uwp)) :: Int

convertStringToBases :: String -> [Base]
convertStringToBases str =
  map readBase $ filter (\ch -> ch /= ' ') str

convertStringToTradeCodes :: String -> [TradeCode]
convertStringToTradeCodes str =
  map readTradeCode $ splitOn " " str

convertStringToTravelZone :: String -> TravelZone
convertStringToTravelZone str = readTravelZone str

-- System Codes are formatted in the following way:
-- 1-12: Name
-- 14-17: Coordinates
-- 19-28: Universal World Profile
-- 30-36: Bases/Gas Giant
-- 39-52: Trade Codes
-- 54: Travel Zone
convertCodeToSystem :: SystemCode -> System
convertCodeToSystem code =
  System { name = parseName
         , coords = parseCoords
         , profile = parseProfile
         , bases = parseBases
         , trade = parseTradeCodes
         , travel = parseTravelZone }
    where
      parseName = unpack $ strip $ pack $ take 12 code
      parseCoords = take 4 $ drop 13 code
      parseProfile = convertStringToUWPInfo $ take 10 $ drop 18 code
      parseBases = convertStringToBases $ unpack $ strip $ pack $ take 7 $ drop 29 code
      parseTradeCodes = convertStringToTradeCodes $ unpack $ strip $ pack $ take 14 $ drop 38 code
      parseTravelZone = convertStringToTravelZone $ take 1 $ drop 53 code


convertCodesToSystems :: [SystemCode] -> Sector
convertCodesToSystems codes = 
  Sector { systems = map convertCodeToSystem codes }
