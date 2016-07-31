module Main exposing (..)

import ElmTest exposing (suite, test, assertEqual)
import LightsGame


all =
    suite "LightsGame"
        [ test "can toggle a light"
            (LightsGame.init [ True ]
                |> LightsGame.update (LightsGame.Toggle 0)
                |> .isOn
                |> assertEqual [ False ]
            )
        , test "toggling a light toggles its right neighbor"
            (LightsGame.init [ False, False, False ]
                |> LightsGame.update (LightsGame.Toggle 0)
                |> .isOn
                |> assertEqual [ True, True, False ]
            )
        , test "toggling a light toggles its left neighbor"
            (LightsGame.init [ False, False, False ]
                |> LightsGame.update (LightsGame.Toggle 2)
                |> .isOn
                |> assertEqual [ False, True, True ]
            )
        ]


main =
    ElmTest.runSuiteHtml all
