module Asset exposing (Image, arie, jake, number, src, win)

{-| Assets, such as images, videos, and audio.

Don't expose asset URLs directly; this module should be in charge of all of them. Better to have
a single source of truth.

-}

import Html exposing (..)
import Html.Attributes as Attr


type Image
    = Image String



-- IMAGES


arie : Image
arie =
    image "arie.jpg"


jake : Image
jake =
    image "jake.jpg"


number : Int -> Image
number =
    String.fromInt
        >> (\numberAsString -> "number-" ++ numberAsString ++ ".jpg")
        >> image


win : Image
win =
    image "win.jpg"


image : String -> Image
image filename =
    Image ("/assets/images/" ++ filename)



-- USING IMAGES


src : Image -> Attribute msg
src (Image url) =
    Attr.src url
