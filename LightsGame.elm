module LightsGame
    exposing
        ( Model
        , init
        , initWithDefaultBoard
        , isSolved
        , Msg(..)
        , update
        , view
        )

import Array
import Html
import Html.Attributes
import Html.Events
import Matrix exposing (Matrix)


type alias Model =
    { isOn : Matrix Bool }


init : Matrix Bool -> Model
init startingBoard =
    { isOn = startingBoard }


initWithDefaultBoard : Model
initWithDefaultBoard =
    { isOn = Matrix.repeat 6 6 False }
        |> update (Toggle { x = 0, y = 0 })
        |> update (Toggle { x = 2, y = 0 })
        |> update (Toggle { x = 1, y = 4 })
        |> update (Toggle { x = 4, y = 2 })
        |> update (Toggle { x = 5, y = 0 })
        |> update (Toggle { x = 0, y = 2 })
        |> update (Toggle { x = 1, y = 1 })


isSolved : Model -> Bool
isSolved model =
    let
        onLights =
            Matrix.filter identity model.isOn
    in
        Array.isEmpty onLights



-- Update


type alias LightIndex =
    { x : Int, y : Int }


type Msg
    = Toggle LightIndex


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle indexToToggle ->
            { model | isOn = toggleLight indexToToggle model.isOn }


toggleLight : LightIndex -> Matrix Bool -> Matrix Bool
toggleLight indexToToggle matrix =
    matrix
        |> Matrix.update indexToToggle.x indexToToggle.y not
        |> Matrix.update (indexToToggle.x + 1) indexToToggle.y not
        |> Matrix.update (indexToToggle.x - 1) indexToToggle.y not
        |> Matrix.update indexToToggle.x (indexToToggle.y + 1) not
        |> Matrix.update indexToToggle.x (indexToToggle.y - 1) not



-- View


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ if isSolved model then
            Html.text "You're a winner!"
          else
            gameView model
        , Html.hr [] []
        , Html.p [] [ Html.text <| toString model ]
        ]


gameView : Model -> Html.Html Msg
gameView model =
    model.isOn
        |> Matrix.indexedMap lightButton
        |> matrixToDivs


matrixToDivs : Matrix (Html.Html Msg) -> Html.Html Msg
matrixToDivs matrix =
    let
        makeRow y =
            Matrix.getRow y matrix
                |> Maybe.map (Array.toList)
                |> Maybe.withDefault []
                |> Html.div []

        height =
            Matrix.height matrix
    in
        [0..height]
            |> List.map makeRow
            |> Html.div []


lightButton : Int -> Int -> Bool -> Html.Html Msg
lightButton x y isOn =
    Html.div
        [ Html.Attributes.style
            [ ( "background-color"
              , if isOn then
                    "orange"
                else
                    "grey"
              )
            , ( "width", "40px" )
            , ( "height", "40px" )
            , ( "border-radius", "4px" )
            , ( "margin", "2px" )
            , ( "display", "inline-block" )
            ]
        , Html.Events.onClick (Toggle { x = x, y = y })
        ]
        []
