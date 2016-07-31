module Main exposing (..)

import Html.App
import LightsGame


main : Program Never
main =
    Html.App.beginnerProgram
        { model = LightsGame.initWithDefaultBoard
        , update = LightsGame.update
        , view = LightsGame.view
        }
