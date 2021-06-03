module RosetteTypes where

type SystemCode = String

data Sector = Sector
  { systems :: [System]
  }

data System = System
  { name :: String
  , coords :: HexCell
  , profile :: UWPInfo
  , bases :: [Base]
  , trade :: [TradeCode]
  , travel :: TravelZone
  }

type HexCell = String

data UWPInfo = UWPInfo
  { starport :: Char
  , size :: Char
  , atmosphere :: Char
  , hydrographic :: Char
  , population :: Char
  , government :: Char
  , law :: Char
  , tech :: Int
  }

data Base = Pirate | Consulate | Travellers | Research | Naval | Scout | Giant

data TradeCode = Ag | As | Ba | De | Fl | Ga | Hi | Ht | Ic
               | In | Lo | Lt | Na | Ni | Po | Ri | Va | Wa

data TravelZone = Amber | Restricted | None
