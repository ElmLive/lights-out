module Main exposing (..)

import Html.App
import MultiGame


main : Program Never
main =
    Html.App.beginnerProgram
        { model = MultiGame.init
        , update = MultiGame.update
        , view = MultiGame.view
        }
