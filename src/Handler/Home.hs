{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

-- This template is described in detail in the School of Haskell tutorials at
-- https://www.fpcomplete.com/school/ide-tutorials/buiding-a-file-hosting-service-in-yesod

module Handler.Home where

import qualified Data.ByteString.Lazy as L
import Data.Conduit
import Data.Conduit.Binary
import Data.Default
import Yesod
import Yesod.Default.Util

import Foundation

getHomeR :: Handler Html
getHomeR = do
    (formWidget, formEncType) <- generateFormPost uploadForm
    storedFiles <- getList
    defaultLayout $ do
        setTitle "File Processor"
        $(widgetFileNoReload def "home")

postHomeR :: Handler Html
postHomeR = do
    ((result, _), _) <- runFormPost uploadForm
    case result of
      FormSuccess fi -> do
        app <- getYesod
        fileBytes <- runResourceT $ fileSource fi $$ sinkLbs
        addFile app $ StoredFile (fileName fi) (fileContentType fi) fileBytes
      _ -> return ()
    redirect HomeR

uploadForm = renderDivs $ fileAFormReq "file"
