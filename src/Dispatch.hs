{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

-- This template is described in detail in the School of Haskell tutorials at
-- https://www.fpcomplete.com/school/ide-tutorials/buiding-a-file-hosting-service-in-yesod

module Dispatch where

import Yesod

import Foundation
import Handler.Download
import Handler.Home
import Handler.Preview

mkYesodDispatch "App" resourcesApp
