module Routes exposing (Route(..), route, toString)

import Url.Parser exposing (Parser, map, oneOf, s, top)


type Route
    = Home
    | Blog
    | About
    | NotFound


route : Parser (Route -> msg) msg
route =
    oneOf
        [ map Home top
        , map Blog (s "blog")
        , map About (s "about")
        ]


toString : Route -> String
toString r =
    case r of
        Home ->
            "home"
        Blog ->
            "blog"
        About ->
            "about"
        NotFound ->
            "not-found"


