module Main where

import Lib
import Messages as Msg
import System.FilePath
import System.Environment
import Prelude hiding (readFile)
import Data.ByteString.Lazy (readFile)
import System.Directory
import qualified Data.Text as T


commitToFS :: FilePath -> TxtFileTree -> IO ()
commitToFS base (File p c) = writeFile (base </> p) (T.unpack c)
commitToFS base (Dir p xs) = createDirectory base' >>
  (foldl1 (>>) $ map (commitToFS base') xs)
  where
    base' = base </> p

msg :: String -> IO ()
msg = putStrLn

action :: Args -> IO ()
action (Args json base) = do
  content <- readFile json
  let result = parseJson content
  case result of
    Nothing     -> msg Msg.wrongJson
    Just parsed -> foldl1 (>>) $ fmap (commitToFS base) parsed

main :: IO ()
main = do
  result <- (parseArgs <$> getArgs) :: IO (Either String Args)
  case result of
    Left e     -> msg e
    Right args -> action args
