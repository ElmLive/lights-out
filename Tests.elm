module Main exposing (..)

import ElmTest exposing (suite, test, assertEqual)
import LightsGame
import Matrix


singleLightBoard =
    Matrix.fromList [ [ True ] ]
        |> Maybe.withDefault Matrix.empty


singleRowBoard =
    Matrix.fromList [ [ False, False, False ] ]
        |> Maybe.withDefault Matrix.empty


squareBoard =
    Matrix.fromList
        [ [ False, False, False ]
        , [ False, False, False ]
        , [ False, False, False ]
        ]
        |> Maybe.withDefault Matrix.empty


all =
    suite "LightsGame"
        [ test "can toggle a light"
            (LightsGame.init singleLightBoard
                |> LightsGame.update (LightsGame.Toggle { x = 0, y = 0 })
                |> .isOn
                |> Matrix.get 0 0
                |> assertEqual (Just False)
            )
        , test "toggling a light toggles its right neighbor"
            (LightsGame.init singleRowBoard
                |> LightsGame.update (LightsGame.Toggle { x = 0, y = 0 })
                |> .isOn
                |> Matrix.get 1 0
                |> assertEqual (Just True)
            )
        , test "toggling a light toggles its left neighbor"
            (LightsGame.init singleRowBoard
                |> LightsGame.update (LightsGame.Toggle { x = 2, y = 0 })
                |> .isOn
                |> Matrix.get 1 0
                |> assertEqual (Just True)
            )
        , test "toggling a light doesn't toggle non-neighbors"
            (LightsGame.init squareBoard
                |> LightsGame.update (LightsGame.Toggle { x = 1, y = 1 })
                |> .isOn
                |> Matrix.get 0 0
                |> assertEqual (Just False)
            )
        , test
            "toggling a light toggles its upper neighbor"
            (LightsGame.init squareBoard
                |> LightsGame.update (LightsGame.Toggle { x = 1, y = 2 })
                |> .isOn
                |> Matrix.get 1 1
                |> assertEqual (Just True)
            )
        , test "toggling a light toggles its lower neighbor"
            (LightsGame.init squareBoard
                |> LightsGame.update (LightsGame.Toggle { x = 1, y = 0 })
                |> .isOn
                |> Matrix.get 1 1
                |> assertEqual (Just True)
            )
        ]


main =
    ElmTest.runSuiteHtml all
