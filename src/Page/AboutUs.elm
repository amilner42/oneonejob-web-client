module Page.AboutUs exposing (view)

{-| A blank page.
-}

import Asset
import Html exposing (..)
import Html.Attributes exposing (..)


view : { title : String, content : Html.Html msg }
view =
    { title = "About Us"
    , content = aboutUsView
    }


aboutUsView : Html.Html msg
aboutUsView =
    div
        []
        [ div
            [ class "section has-text-centered" ]
            [ h1
                [ class "title is-1"
                , style "padding-bottom" "30px"
                ]
                [ text "Hello World" ]
            , div
                [ class "columns" ]
                [ renderUserBio arieBio
                , renderUserBio jakeBio
                ]
            ]
        ]


renderUserBio : BioData -> Html.Html msg
renderUserBio { name, image, bio } =
    div
        [ class "column is-one-half"
        , style "padding-bottom" "50px"
        ]
        [ img
            [ Asset.src image
            , style "width" "100%"
            , style "max-width" "350px"
            , style "border-radius" "350px"
            ]
            []
        , div
            []
            [ div [ class "title is-4" ] [ text name ]
            , div [ class "content" ] [ text bio ]
            ]
        ]


paddingOneSixthColumn : Html.Html msg
paddingOneSixthColumn =
    div [ class "column is-one-sixth" ] []


type alias BioData =
    { name : String
    , image : Asset.Image
    , bio : String
    }


arieBio : BioData
arieBio =
    { name = "Arie Milner"
    , image = Asset.arie
    , bio = """Work experience at Radify and Google. An advocate of practical functional programming and an avid
    theorist and experimentalist on how to make programming suck less. Previous host of the wonderful Elm remote
    meetups. UBC Computer Science graduate."""
    }


jakeBio : BioData
jakeBio =
    { name = "Jake Elward"
    , image = Asset.jake
    , bio = """Former CEO of Kitau, winners of the Pacific Venture Capital Competition. Top design in NVD,
    RBC Get Seeded and Founders Live. Former Product Manager at Grow Technologies. UBC Integrated Engineering
    graduate."""
    }
