{-# LANGUAGE OverloadedStrings  #-}

module Messages where

import Data.List
import Text.Printf

newlines :: [String] -> String
newlines = concat . intersperse "\n"

help = newlines [
    "Usage: jfo json-file base-dir"
  ]

noFileName, noDirName :: String -> String

noFileName = printf "\"%s\" is no valid file name" 
noDirName  = printf "\"%s\" is no valid directory name"

wrongJson = "Cannot parse JSON."
