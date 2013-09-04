{-# LANGUAGE OverloadedStrings #-}

-- This template is described in detail in the School of Haskell tutorials at
-- https://www.fpcomplete.com/school/ide-tutorials/buiding-a-file-hosting-service-in-yesod

module Main where

import Control.Concurrent.STM
import Data.IntMap
import Yesod

import Dispatch ()
import Foundation

main :: IO ()
main = do
    tstore <- atomically $ newTVar empty
    tident <- atomically $ newTVar 0
    warpEnv $ App tident tstore
