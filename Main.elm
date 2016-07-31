module Main exposing (..)

import Html.App
import LightsGame


main =
    Html.App.beginnerProgram
        { model = LightsGame.init
        , update = LightsGame.update
        , view = LightsGame.view
        }
