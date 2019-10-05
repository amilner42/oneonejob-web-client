module Page exposing (view)

{-| This allows you to insert a page, providing the navbar outline common to all pages.
-}

import Asset
import Browser exposing (Document)
import Html exposing (Html, a, button, div, h1, h2, i, img, li, nav, p, section, span, strong, text, ul)
import Html.Attributes exposing (class, classList, href, style)
import Html.Events exposing (onClick)
import Route exposing (Route)


{-| Take a page's Html and frames it with a navbar.
-}
view :
    Bool
    -> { mobileNavbarOpen : Bool, toggleMobileNavbar : msg }
    -> { title : String, content : Html pageMsg }
    -> (pageMsg -> msg)
    -> Document msg
view showHero navConfig { title, content } toMsg =
    { title = title
    , body =
        if showHero then
            viewHero navConfig :: List.map (Html.map toMsg) [ content ]

        else
            renderNavbar navConfig :: List.map (Html.map toMsg) [ content ]
    }


{-| Render the hero.
-}
viewHero : { mobileNavbarOpen : Bool, toggleMobileNavbar : msg } -> Html msg
viewHero navConfig =
    div
        [ class "hero is-fullheight is-info is-bold" ]
        [ renderNavbar navConfig
        , div
            [ class "hero-body" ]
            [ div
                [ class "container has-text-centered" ]
                [ h1
                    [ class "title" ]
                    [ text "Enough. Whiteboard. Interviews." ]
                , h2
                    [ class "subtitle" ]
                    [ text "introducing a more effective and meaningful hiring process" ]
                , button
                    [ class "button is-medium" ]
                    [ text "follow project progress" ]
                ]
            ]
        ]


renderNavbar : { mobileNavbarOpen : Bool, toggleMobileNavbar : msg } -> Html msg
renderNavbar { mobileNavbarOpen, toggleMobileNavbar } =
    nav [ class "navbar is-info" ]
        [ div
            [ class "navbar-brand" ]
            [ div
                [ class "navbar-item"
                , style "font-family" "Roboto Condensed, sans-serif"
                , style "font-weight" "700"
                ]
                [ div [ class "title is-3", style "color" "white" ] [ text "ONE ONE JOB" ] ]
            , div
                [ classList
                    [ ( "navbar-burger", True )
                    , ( "is-active", mobileNavbarOpen )
                    ]
                , onClick toggleMobileNavbar
                ]
                [ span [] [], span [] [], span [] [] ]
            ]
        , div
            [ classList
                [ ( "navbar-menu", True )
                , ( "is-active", mobileNavbarOpen )
                ]
            ]
            [ div
                [ class "navbar-end" ]
                [ a [ class "navbar-item", Route.href Route.Home ] [ text "Home" ]
                , a
                    [ class "navbar-item", Route.href Route.AboutUs ]
                    [ text "About Us" ]
                ]
            ]
        ]
