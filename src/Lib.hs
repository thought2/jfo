module Lib where

import Messages as Msg
import System.FilePath
import Data.Aeson
import Data.ByteString.Lazy.Internal
import Data.HashMap.Lazy (toList)
import qualified Data.Text as T


data Args = Args { jsonPath :: FilePath, baseDir :: FilePath }
  deriving Show

data TxtFileTree
  = File {filePath :: FilePath, content :: T.Text}
  | Dir  {dirPath  :: FilePath, files   :: [TxtFileTree]}
  deriving Show

parseArgs :: [String] -> Either String Args               
parseArgs [json, base]
  | not $ isFileName json = Left $ Msg.noFileName json
  | not $ isValid base    = Left $ Msg.noDirName base
  | otherwise             = Right $ Args json base
parseArgs _ =
  Left Msg.help

isFileName :: FilePath -> Bool
isFileName b = (takeBaseName b /= mempty) 

parseObj ::  Object -> [TxtFileTree]
parseObj xs =
  map (\(key, val) -> case val of
          (Object o) -> Dir (T.unpack key) (parseObj o)
          (String s) -> File (T.unpack key) s)
  (toList xs)

parseJson :: ByteString -> Maybe [TxtFileTree]
parseJson s =
  parseObj <$> (decode s :: Maybe Object)

