{-# LANGUAGE OverloadedStrings  #-}

module Messages where

import Data.List
import Text.Printf

newlines :: [String] -> String
newlines = concat . intersperse "\n"

help = newlines [
    "Usage: jfo json-file base-dir"
  , "x"
  ]

noFileName, noDirName, noDir, noFile :: String -> String

noFileName = printf "\"%s\" is no valid file name" 
noDirName  = printf "\"%s\" is no valid directory name"

noDir = printf "directory \"%s\" doesn't exist"
noFile = printf "file \"%s\" doesn't exist"

unknownError = "An unknown error occured."

wrongJson = "Cannot parse JSON."
