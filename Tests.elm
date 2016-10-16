module Main exposing (..)

import Test exposing (describe, test)
import Expect
import LightsGame
import Matrix
import Test.Runner.Html


singleLightBoard =
    Matrix.fromList [ [ Just True ] ]
        |> Maybe.withDefault Matrix.empty


singleRowBoard =
    Matrix.fromList [ [ Just False, Just False, Just False ] ]
        |> Maybe.withDefault Matrix.empty


squareBoard =
    Matrix.fromList
        [ [ Just False, Just False, Just False ]
        , [ Just False, Just False, Just False ]
        , [ Just False, Just False, Just False ]
        ]
        |> Maybe.withDefault Matrix.empty


all =
    describe "LightsGame"
        [ test "can toggle a light" <|
            \() ->
                LightsGame.init singleLightBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 0, y = 0 })
                    |> .isOn
                    |> Matrix.get 0 0
                    |> Expect.equal (Just <| Just False)
        , test "toggling a light toggles its right neighbor" <|
            \() ->
                LightsGame.init singleRowBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 0, y = 0 })
                    |> .isOn
                    |> Matrix.get 1 0
                    |> Expect.equal (Just <| Just True)
        , test "toggling a light toggles its left neighbor" <|
            \() ->
                LightsGame.init singleRowBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 2, y = 0 })
                    |> .isOn
                    |> Matrix.get 1 0
                    |> Expect.equal (Just <| Just True)
        , test "toggling a light doesn't toggle non-neighbors" <|
            \() ->
                LightsGame.init squareBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 1, y = 1 })
                    |> .isOn
                    |> Matrix.get 0 0
                    |> Expect.equal (Just <| Just False)
        , test "toggling a light toggles its upper neighbor" <|
            \() ->
                LightsGame.init squareBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 1, y = 2 })
                    |> .isOn
                    |> Matrix.get 1 1
                    |> Expect.equal (Just <| Just True)
        , test "toggling a light toggles its lower neighbor" <|
            \() ->
                LightsGame.init squareBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 1, y = 0 })
                    |> .isOn
                    |> Matrix.get 1 1
                    |> Expect.equal (Just <| Just True)
        , describe "isSolved"
            [ test "True when all lights are off" <|
                \() ->
                    LightsGame.init squareBoard
                        |> LightsGame.isSolved
                        |> Expect.equal True
            , test "False when some lights are on" <|
                \() ->
                    LightsGame.init squareBoard
                        |> LightsGame.update (LightsGame.Toggle { x = 0, y = 0 })
                        |> LightsGame.isSolved
                        |> Expect.equal False
            ]
        ]


main =
    Test.Runner.Html.run all
