module Printer where

import Data.List

import RosetteTypes

{- PRINTERS -}

cascadePrintInternal :: (Show a) => [a] -> String
cascadePrintInternal []  = "| \\ None"
cascadePrintInternal [x] = "| \\ " ++ (show x)
cascadePrintInternal xs  =
  "| | " ++ xsString
    where
      xsString = (intercalate "\n| | " $ map show $ init xs)
              ++ "\n| \\ " ++ (show $ last xs)

cascadePrint :: (Show a) => [a] -> String
cascadePrint []  = "\\ None"
cascadePrint [x] = "\\ " ++ (show x)
cascadePrint xs  =
  "| " ++ xsString
    where
      xsString = (intercalate "\n| " $ map show $ init xs)
              ++ "\n\\ " ++ (show $ last xs)

printSystems :: Sector -> String
printSystems sector =
  init $ intercalate "\n" $ map show (systems sector)
  -- init is there to remove the extra newline at the end of the output

printUWPString :: UWPInfo -> String
printUWPString uwp =
  [ starport uwp
  , size uwp
  , atmosphere uwp
  , hydrographic uwp
  , population uwp
  , government uwp
  , law uwp
  , '-'
  ] ++ (show $ tech uwp)

printStarportInfo :: Char -> String
printStarportInfo ch =
  case ch of
    'A' -> "Excellent\n| Facilities:\n" ++ (cascadePrintInternal ["Shipyard (all)", "Repair"])
    'B' -> "Good\n| Facilities:\n" ++ (cascadePrintInternal ["Shipyard (spacecraft)", "Repair"])
    'C' -> "Routine\n| Facilities:\n" ++ (cascadePrintInternal ["Shipyard (small craft)", "Repair"])
    'D' -> "Poor\n| Facilities:\n" ++ (cascadePrintInternal ["Limited Repair"])
    'E' -> "Frontier\n| Facilities:\n" ++ (cascadePrintInternal ["None"])
    'X' -> "No Starport"

printSizeInfo :: Char -> String
printSizeInfo ch =
  case ch of
    '0' -> "Less than 1,000 km/Negligible Gravity"
    '1' -> "1,600 km/0.05G"
    '2' -> "3,200 km/0.15G"
    '3' -> "4,800 km/0.25G"
    '4' -> "6,400 km/0.35G"
    '5' -> "8,000 km/0.45G"
    '6' -> "9,600 km/0.70G"
    '7' -> "11,200 km/0.90G"
    '8' -> "12,800 km/1.00G"
    '9' -> "14,400 km/1.25G"
    'A' -> "16,000 km/1.40G"

printAtmosphereInfo :: Char -> String
printAtmosphereInfo ch =
  case ch of
    '0' -> "None\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["Vacc Suit"])
    '1' -> "Trace\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["Vacc Suit"])
    '2' -> "Very Thin, Tainted\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["Respirator", "Filter"])
    '3' -> "Very Thin\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["Respirator"])
    '4' -> "Thin, Tainted\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["Filter"])
    '5' -> "Thin\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["None"])
    '6' -> "Standard\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["None"])
    '7' -> "Standard, Tainted\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["Filter"])
    '8' -> "Dense\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["None"])
    '9' -> "Dense, Tainted\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["Filter"])
    'A' -> "Exotic\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["Air Supply"])
    'B' -> "Corrosive\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["Vacc Suit"])
    'C' -> "Insidious\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["Vacc Suit"])
    'D' -> "Very Dense\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["None"])
    'E' -> "Low\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["None"])
    'F' -> "Unusual\n| Required Survival Gear:\n" ++ (cascadePrintInternal ["Varies"])

printHydrographicsInfo :: Char -> String
printHydrographicsInfo ch =
  case ch of
    '0' -> "Desert world (0% - 5%)"
    '1' -> "Dry world (6% - 15%)"
    '2' -> "A few small seas (16% - 25%)"
    '3' -> "Small seas and oceans (26% - 35%)"
    '4' -> "Wet world (36% - 45%)"
    '5' -> "Large oceans (46% - 55%)"
    '6' -> "Massive oceans (56% - 65%)"
    '7' -> "Earth-like world (66% - 75%)"
    '8' -> "Water world (76% - 85%)"
    '9' -> "Only a few small islands and archipelagos (86% - 95%)"
    'A' -> "Almost entirely water (96% - 100%)"

printPopulationInfo :: Char -> String
printPopulationInfo ch =
  case ch of
    '0' -> "Uninhabited"
    '1' -> "~10"
    '2' -> "~100"
    '3' -> "~1,000"
    '4' -> "~10,000"
    '5' -> "~100,000"
    '6' -> "~1,000,000"
    '7' -> "~10,000,000"
    '8' -> "~100,000,000"
    '9' -> "~1,000,000,000"
    'A' -> "~10,000,000,000"
    'B' -> "~100,000,000,000"
    'C' -> "~1,000,000,000,000"

printGovernmentInfo :: Char -> String
printGovernmentInfo ch =
  case ch of
    '0' -> "None\n| Common Contraband:\n" ++ (cascadePrintInternal ["None"])
    '1' -> "Company/Corporation\n| Common Contraband:\n" ++ (cascadePrintInternal ["Weapons", "Drugs", "Travellers"])
    '2' -> "Participating Democracy\n| Common Contraband:\n" ++ (cascadePrintInternal ["Drugs"])
    '3' -> "Self-Perpetuating Oligarchy\n| Common Contraband:\n" ++ (cascadePrintInternal ["Technology", "Weapons", "Travellers"])
    '4' -> "Representative Democracy\n| Common Contraband:\n" ++ (cascadePrintInternal ["Drugs", "Weapons", "Psionics"])
    '5' -> "Feudal Technocracy\n| Common Contraband:\n" ++ (cascadePrintInternal ["Technology", "Weapons", "Computers"])
    '6' -> "Captive Government\n| Common Contraband:\n" ++ (cascadePrintInternal ["Technology", "Weapons", "Travellers"])
    '7' -> "Balkanisation\n| Common Contraband:\n" ++ (cascadePrintInternal ["Varies"])
    '8' -> "Civil Service Bureaucracy\n| Common Contraband:\n" ++ (cascadePrintInternal ["Drugs", "Weapons"])
    '9' -> "Impersonal Bureaucracy\n| Common Contraband:\n" ++ (cascadePrintInternal ["Technology", "Drugs", "Weapons", "Travellers", "Psionics"])
    'A' -> "Charismatic Dictator\n| Common Contraband:\n" ++ (cascadePrintInternal ["None"])
    'B' -> "Non-Charismatic Leader\n| Common Contraband:\n" ++ (cascadePrintInternal ["Weapons", "Technology", "Computers"])
    'C' -> "Charismatic Oligarchy\n| Common Contraband:\n" ++ (cascadePrintInternal ["Weapons"])
    'D' -> "Religious Dictatorship\n| Common Contraband:\n" ++ (cascadePrintInternal ["Varies"])
    'E' -> "Religious Autocracy\n| Common Contraband:\n" ++ (cascadePrintInternal ["Varies"])
    'F' -> "Totalitarian Oligarchy\n| Common Contraband:\n" ++ (cascadePrintInternal ["Varies"])

printLawLevelInfo :: Char -> String
printLawLevelInfo ch =
  case ch of
    '0' -> "No Restrictions"
    '1' -> "No poison gas, explosives, undetectable weapons, WMDs, or battle dress"
    '2' -> "No portable energy/laser weapons or combat armor"
    '3' -> "No military weapons or flak armor"
    '4' -> "No light assault weapons, submachine guns, or cloth armor"
    '5' -> "No personal concealable weapons or mesh armor"
    '6' -> "No firearms except shotguns and stunners"
    '7' -> "No shotguns"
    '8' -> "No bladed weapons, stunners, or visible armor"
    _   -> "All weapons and armor are banned"

printTechLevelInfo :: Int -> String
printTechLevelInfo int =
  case int of
    0  -> "TL " ++ (show int) ++ " (Primitive)"
    1  -> "TL " ++ (show int) ++ " (Primitive)"
    2  -> "TL " ++ (show int) ++ " (Primitive)"
    3  -> "TL " ++ (show int) ++ " (Primitive)"
    4  -> "TL " ++ (show int) ++ " (Industrial)"
    5  -> "TL " ++ (show int) ++ " (Industrial)"
    6  -> "TL " ++ (show int) ++ " (Industrial)"
    7  -> "TL " ++ (show int) ++ " (Pre-Stellar)"
    8  -> "TL " ++ (show int) ++ " (Pre-Stellar)"
    9  -> "TL " ++ (show int) ++ " (Pre-Stellar)"
    10 -> "TL " ++ (show int) ++ " (Early Stellar)"
    11 -> "TL " ++ (show int) ++ " (Early Stellar)"
    12 -> "TL " ++ (show int) ++ " (Average Stellar)"
    13 -> "TL " ++ (show int) ++ " (Average Stellar)"
    14 -> "TL " ++ (show int) ++ " (Average Stellar)"
    _  -> "TL " ++ (show int) ++ " (High Stellar)"
    -- Anything above 14 is considered "High Stellar"

{- SHOW INSTANCES -}

instance Show Sector where
  show sector = printSystems sector

instance Show System where
  show system = "System Name: " ++ (show $ name system) ++ "\n"
             ++ "Coordinates: " ++ (show $ coords system) ++ "\n"
             ++ "UWP: " ++ (printUWPString $ profile system) ++ "\n"
             ++ (show $ profile system) ++ "\n"
             ++ "Bases:" ++ "\n"
             ++ (cascadePrint $ bases system) ++ "\n"
             ++ "Trade Codes: " ++ "\n"
             ++ (cascadePrint $ trade system) ++ "\n"
             ++ "Travel Zone: " ++ (show $ travel system) ++ "\n"

instance Show UWPInfo where
  show uwp = "| Starport Quality: " ++ (printStarportInfo $ starport uwp) ++ "\n"
          ++ "| Planet Size/Gravity: " ++ (printSizeInfo $ size uwp) ++ "\n"
          ++ "| Atmosphere: " ++ (printAtmosphereInfo $ atmosphere uwp) ++ "\n"
          ++ "| Hydrographics: " ++ (printHydrographicsInfo $ hydrographic uwp) ++ "\n"
          ++ "| Population Size: " ++ (printPopulationInfo $ population uwp) ++ "\n"
          ++ "| Government Type: " ++ (printGovernmentInfo $ government uwp) ++ "\n"
          ++ "| Law Level: " ++ (printLawLevelInfo $ law uwp) ++ "\n"
          ++ "\\ Tech Level: " ++ (printTechLevelInfo $ tech uwp)

instance Show Base where
  show Pirate     = "Pirate Base"
  show Consulate  = "Imperial Consulate"
  show Travellers = "Traveller's Aid Society Facility"
  show Research   = "Research Station"
  show Naval      = "Naval Base"
  show Scout      = "Scout Base"
  show Giant      = "Gas Giant"

instance Show TradeCode where
  show Ag = "Agricultural"
  show As = "Asteroid"
  show Ba = "Barren"
  show De = "Desert"
  show Fl = "Fluid Oceans"
  show Ga = "Garden"
  show Hi = "High Population"
  show Ht = "High Technology"
  show Ic = "Ice-Capped"
  show In = "Industrial"
  show Lo = "Low Population"
  show Lt = "Low Technology"
  show Na = "Non-Agricultural"
  show Ni = "Non-Industrial"
  show Po = "Poor"
  show Ri = "Rich"
  show Va = "Vacuum"
  show Wa = "Water World"

instance Show TravelZone where
  show Amber = "Amber Zone"
  show Restricted = "Restricted Zone"
  show None = "None"
