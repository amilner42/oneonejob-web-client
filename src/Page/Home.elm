module Page.Home exposing (Model, Msg, init, initModel, update, view)

{-| The homepage. You can get here via either the / or /#/ routes.
-}

import Api.Api as Api
import Api.Core as Core
import Api.Errors.Form as FormError
import Asset
import Browser.Navigation as Nav
import Bulma
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- MODEL


type alias Model =
    { navKey : Nav.Key
    , email : String
    , emailFormError : FormError.Error
    }


init : Nav.Key -> ( Model, Cmd Msg )
init navKey =
    ( initModel navKey, Cmd.none )


initModel : Nav.Key -> Model
initModel navKey =
    { navKey = navKey, email = "", emailFormError = FormError.empty }



-- VIEW


view : Model -> { title : String, content : Html Msg }
view model =
    { title = "Home"
    , content =
        div
            []
            [ renderPanel1
            , renderPanel2 model.email model.emailFormError
            ]
    }


renderPanel1 : Html Msg
renderPanel1 =
    div
        [ class "column"
        , style "padding" "50px 0"
        ]
        [ div [ class "columns is-multiline has-text-centered" ] <|
            renderCenteredNumberAndTextCombo
                { text = "Companies send us job postings."
                , image = Asset.number 1
                }
                ++ renderCenteredNumberAndTextCombo
                    { text = "We recommend relevant open source issues for companies."
                    , image = Asset.number 2
                    }
                ++ renderCenteredNumberAndTextCombo
                    { text = "Jobseekers solve these open source issues to get interviews."
                    , image = Asset.number 3
                    }
                ++ renderWinColumnThird
                    { text = "Companies get better interviews and hires thanks to being able to see people solve relevant and real problems."
                    , image = Asset.win
                    }
                ++ renderWinColumnThird
                    { text = "Jobseekers build their portfolio and attain real skills while working on real problems with real people."
                    , image = Asset.win
                    }
                ++ renderWinColumnThird
                    { text = "Open source partners get more contributors solving difficult issues that benefit the entire community."
                    , image = Asset.win
                    }
        ]


renderPanel2 : String -> FormError.Error -> Html Msg
renderPanel2 email emailFormError =
    div
        [ class "column"
        , style "background-color" "whitesmoke"
        ]
        [ div
            [ class "columns is-centered has-text-centered" ]
            [ div [ class "column is-half" ]
                [ div
                    [ class "content"
                    , style "padding-top" "30px"
                    ]
                    [ h1
                        [ class "title is-2" ]
                        [ text "Follow Project Progress" ]
                    , text "We hate spam. We will only email you for important progress updates."
                    ]
                , p
                    [ class "title is-size-7 has-text-danger has-text-centered" ]
                    (List.map text <| emailFormError.entire)
                , Bulma.formControl
                    (\hasError ->
                        input
                            [ classList [ ( "input", True ), ( "is-danger", hasError ) ]
                            , placeholder "Email"
                            , onInput OnEmailInput
                            , value email
                            , style "text-align" "center"
                            ]
                            []
                    )
                    (FormError.getErrorForField "email" emailFormError)
                , Bulma.formControl
                    (\hasError ->
                        textarea
                            [ classList [ ( "input", True ), ( "is-danger", hasError ) ]
                            , placeholder "Optional Extra Information"
                            , onInput OnEmailInput
                            , value email
                            , style "text-align" "center"
                            , style "min-height" "200px"
                            ]
                            []
                    )
                    (FormError.getErrorForField "info" emailFormError)
                , button
                    [ class "button is-dark is-fullwidth"
                    , onClick AddEmail
                    ]
                    [ text "Subscribe For Updates" ]
                ]
            ]
        ]


type alias ImageTextPair =
    { text : String
    , image : Asset.Image
    }


renderCenteredNumberAndTextCombo : ImageTextPair -> List (Html msg)
renderCenteredNumberAndTextCombo config =
    [ div [ class "column is-one-quarter" ] []
    , div
        [ class "column is-one-quarter has-text-centered" ]
        [ img [ Asset.src config.image, style "height" "190px" ] [] ]
    , div
        [ class "column is-one-quarter"
        , style "height" "190px"
        ]
        [ div
            [ class "level level-item has-text-centered-mobile"
            , style "height" "100%"
            , style "padding" "10px"
            ]
            [ text config.text ]
        ]
    , div [ class "column is-one-quarter" ] []
    ]


renderWinColumnThird : ImageTextPair -> List (Html msg)
renderWinColumnThird config =
    [ div
        [ class "column is-one-third has-text-centered is-centered" ]
        [ div
            [ class "level" ]
            [ img
                [ Asset.src config.image, style "height" "190px", style "margin" "auto" ]
                []
            ]
        , div
            [ class "content", style "padding" "10px" ]
            [ text config.text ]
        ]
    ]



-- UPDATE


type Msg
    = OnEmailInput String
    | AddEmail
    | CompletedAddEmail (Result (Core.HttpError FormError.Error) ())


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        OnEmailInput email ->
            ( { model | email = email }, Cmd.none )

        AddEmail ->
            ( model
            , Api.addEmail model.email CompletedAddEmail
            )

        CompletedAddEmail (Err httpError) ->
            ( { model | emailFormError = FormError.fromHttpError httpError }, Cmd.none )

        CompletedAddEmail (Ok _) ->
            ( { model | email = "", emailFormError = FormError.empty }, Cmd.none )
