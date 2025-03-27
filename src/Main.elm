module Main exposing (main)

import Browser
import Html exposing (Html, button, div, form, h1, h2, input, label, main_, p, section, small, strong, text)
import Html.Attributes exposing (class, classList, for, id, type_)
import Html.Events exposing (onInput, onSubmit)


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { firstName : String
    , firstNameError : Maybe String
    }


init : Model
init =
    { firstName = ""
    , firstNameError = Nothing
    }



-- UPDATE


type Msg
    = FirstName String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        FirstName firstName ->
            { model
                | firstName = firstName
            }

        Submit ->
            { model | firstNameError = validateName model.firstName }


validateName : String -> Maybe String
validateName inputName =
    if String.length inputName == 0 then
        Just "First name cannot be empty"

    else
        Nothing


view : Model -> Html Msg
view model =
    main_ [ class "container" ]
        [ div [ class "container-wrapper" ]
            [ section [ class "hero-container" ]
                [ div [ class "hero-wrapper" ]
                    [ h1 [ class "heading" ] [ text "Learn to code by watching others" ]
                    , p [ class "detail-description" ] [ text "See how experienced developers solve problems in real-time. Watching scripted tutorials is great, but understanding how developers think is invaluable. " ]
                    ]
                ]
            , section [ class "form-group" ]
                [ div [ class "form-heading-wrapper" ]
                    [ h2 [ class "sub-heading" ]
                        [ strong [ class "strong" ] [ text "Try it free 7 days" ]
                        , text " then $20/mo. thereafter"
                        ]
                    ]
                , div [ class "form-wrapper" ]
                    [ form [ class "form", onSubmit Submit ]
                        [ div []
                            [ div []
                                [ label [ for "firstName" ] [ text "FirstName" ]
                                , input [ id "firstName", type_ "text", onInput FirstName ] []
                                ]
                            , viewValidateName model.firstNameError
                            ]
                        , button [] [ text "CLAIM YOUR FREE TRIAL" ]
                        ]
                    , div [] [ text model.firstName ]
                    ]
                ]
            ]
        ]


viewValidateName : Maybe String -> Html msg
viewValidateName maybeError =
    case maybeError of
        Just errorDetail ->
            small [] [ text errorDetail ]

        Nothing ->
            small [] [ text "OK" ]
