module Main exposing (main)

import Browser
import Char exposing (isDigit, isUpper)
import Html exposing (Html, a, button, div, form, h1, h2, input, label, main_, p, section, small, strong, text)
import Html.Attributes exposing (class, classList, for, href, id, placeholder, target, type_)
import Html.Events exposing (onInput, onSubmit)
import Regex


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { firstName : String
    , lastName : String
    , email : String
    , password : String
    , firstNameError : Maybe String
    , lastNameError : Maybe String
    , emailError : Maybe String
    , passwordError : Maybe String
    }


init : Model
init =
    { firstName = ""
    , lastName = ""
    , email = ""
    , password = ""
    , firstNameError = Nothing
    , lastNameError = Nothing
    , emailError = Nothing
    , passwordError = Nothing
    }



-- UPDATE


type Msg
    = FirstName String
    | LastName String
    | Email String
    | Password String
    | Submit


update : Msg -> Model -> Model
update msg model =
    case msg of
        FirstName firstName ->
            { model
                | firstName = firstName
            }

        LastName lastName ->
            { model | lastName = lastName }

        Email email ->
            { model | email = email }

        Password password ->
            { model | password = password }

        Submit ->
            { model
                | firstNameError = validateFirst model.firstName
                , lastNameError = validateLast model.lastName
                , emailError = validateEmail model.email
                , passwordError = validatePassword model.password
            }


validatePassword : String -> Maybe String
validatePassword password =
    if String.length password == 0 then
        Just "Password cannot be empty"

    else if String.length password < 8 then
        Just "Password must be at least 8 chars length"

    else if not (String.any isUpper password) then
        Just "Password must contain at least 1 uppercase"

    else if not (String.any isDigit password) then
        Just "Password must contain digits"

    else
        Nothing


validateEmail : String -> Maybe String
validateEmail email =
    if String.length email == 0 then
        Just "Email cannot be empty"

    else if Regex.contains isValidEmail email == False then
        Just "Looks like this is not an email"

    else
        Nothing


validateFirst : String -> Maybe String
validateFirst inputName =
    if String.length inputName == 0 then
        Just "First name cannot be empty"

    else
        Nothing


validateLast : String -> Maybe String
validateLast inputName =
    if String.length inputName == 0 then
        Just "Last name cannot be empty"

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
                , div [ class "form-container" ]
                    [ form [ class "form", onSubmit Submit ]
                        [ div [ class "input-wrapper" ]
                            [ label [ class "label", for "firstName" ] [ text "First Name" ]
                            , input [ classList [ ( "input", True ), ( "error-input", model.firstNameError /= Nothing ) ], id "firstName", type_ "text", placeholder "First Name", onInput FirstName ] []
                            , viewValidate model.firstNameError
                            ]
                        , div [ class "input-wrapper" ]
                            [ label [ class "label", for "lastName" ] [ text "Last Name" ]
                            , input [ classList [ ( "input", True ), ( "error-input", model.lastNameError /= Nothing ) ], id "lastName", type_ "text", placeholder "Last Name", onInput LastName ] []
                            , viewValidate model.lastNameError
                            ]
                        , div [ class "input-wrapper" ]
                            [ label [ class "label", for "email" ] [ text "Email" ]
                            , input [ classList [ ( "input", True ), ( "error-input", model.emailError /= Nothing ) ], id "email", type_ "text", placeholder "Email Address", onInput Email ] []
                            , viewValidate model.emailError
                            ]
                        , div [ class "input-wrapper" ]
                            [ label [ class "label", for "password" ] [ text "Password" ]
                            , input [ classList [ ( "input", True ), ( "error-input", model.passwordError /= Nothing ) ], id "password", type_ "password", placeholder "Password", onInput Password ] []
                            , viewValidate model.passwordError
                            ]
                        , button [ class "button" ] [ text "CLAIM YOUR FREE TRIAL" ]
                        ]
                    , p [ class "condition" ]
                        [ text "By clicking the button, you are agreeing to our "
                        , a
                            [ href "https://www.frontendmentor.io/home"
                            , target "_blank"
                            ]
                            [ text "Terms and Services" ]
                        ]
                    ]
                ]
            ]
        ]


viewValidate : Maybe String -> Html msg
viewValidate maybeError =
    case maybeError of
        Just errorDetail ->
            small [ class "error-msg" ] [ text errorDetail ]

        Nothing ->
            small [ class "error-msg" ] [ text "" ]


pattern =
    "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"


isValidEmail : Regex.Regex
isValidEmail =
    Maybe.withDefault Regex.never <| Regex.fromString pattern
