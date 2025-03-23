module Main exposing (main)

import Browser
import Html exposing (Html, button, div, form, input, label, main_, section, small, text)
import Html.Attributes exposing (for, id, type_)
import Html.Events exposing (onInput)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { firstName : String
    }


init : Model
init =
    { firstName = ""
    }



-- UPDATE


type Msg
    = FirstName String


update : Msg -> Model -> Model
update msg model =
    case msg of
        FirstName firstName ->
            { model
                | firstName = firstName
            }


view : Model -> Html Msg
view model =
    main_ []
        [ section []
            [ div []
                [ form []
                    [ div []
                        [ div []
                            [ label [ for "firstName" ] [ text "FirstName" ]
                            , input [ id "firstName", type_ "text", onInput FirstName ] []
                            ]
                        , viewValidateName model.firstName
                        ]
                    , button [] [ text "CLAIM YOUR FREE TRIAL" ]
                    ]
                , div [] [ text model.firstName ]
                ]
            ]
        ]


viewValidateName : String -> Html msg
viewValidateName inputName =
    if String.length inputName == 0 then
        small [] [ text "first name error" ]

    else
        small [] [ text "OK" ]
