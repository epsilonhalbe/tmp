{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

module Site
  ( app
  ) where

------------------------------------------------------------------------------
import           Data.ByteString (ByteString)
import           Snap.Snaplet (SnapletInit, makeSnaplet, addRoutes)
import           Snap.Blaze (blaze)
import qualified Text.Blaze.Html5 as H
------------------------------------------------------------------------------
import           Application

------------------------------------------------------------------------------
-- | The application's routes.
routes :: [(ByteString, AppHandler ())]
routes = [ ("/", rootHandler)
         ]
rootHandler :: AppHandler ()
rootHandler = blaze $ H.docTypeHtml $ do
------------------------------------------------------------------------------
    H.head $ do
        H.title "cpp-wtf"
    H.body $ do
#ifdef DEVELOPMENT
        H.h1 "DEV mode"
#else
        H.h1 "no DEV mode"
#endif

#ifdef PRODUCTION
        H.h1 "PRD mode"
#else
        H.h1 "no PRD mode"
#endif

------------------------------------------------------------------------------
-- | The application initializer.
app :: SnapletInit App App
app = makeSnaplet "app" "An snaplet example application." Nothing $ do
    addRoutes routes
    return $ App

