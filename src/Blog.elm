module Blog exposing (Model, init, view)

import Blogs.ElmTauri_1 exposing (description)
import Element exposing (..)
import Component.Theme as Theme
import Element.Border as Border
import Element.Font as Font


type alias Blog =
    { title : String
    , description : String
    }


type alias Model =
    { blogs : List Blog
    }


init : Model
init =
    { blogs =
        [ { title = Blogs.ElmTauri_1.title
          , description = Blogs.ElmTauri_1.description
          }
        ]
    }


view : Model -> Element msg
view model =
    column [ width fill, height fill ]
        [ column [ centerX ]
            (model.blogs
                |> List.map blog
            )
        ]


blog : Blog -> Element msg
blog { title, description } =
    column [ Theme.spacing 1, Border.width 1, Border.rounded 4
    , Theme.padding 2
    ]
        [ el [ Font.size 16, Font.bold ] <| text title
        , el [ Font.size 16 ] <| text description
        ]
