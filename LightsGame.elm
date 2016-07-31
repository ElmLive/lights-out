module LightsGame exposing (Model, init, update, view)

import Html
import Html.Attributes
import Html.Events


type alias Model =
    { isOn : Bool }


init =
    { isOn = True }


type Msg
    = Toggle


update msg model =
    case msg of
        Toggle ->
            { model | isOn = not model.isOn }


view model =
    Html.div []
        [ Html.div
            [ Html.Attributes.style
                [ ( "background-color"
                  , if model.isOn then
                        "orange"
                    else
                        "grey"
                  )
                , ( "width", "80px" )
                , ( "height", "80px" )
                , ( "border-radius", "4px" )
                , ( "margin", "2px" )
                ]
            , Html.Events.onClick Toggle
            ]
            []
        , Html.hr [] []
        , Html.pre [] [ Html.text <| toString model ]
        ]
