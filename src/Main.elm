module Main exposing (main)

import Browser
import Browser.Navigation exposing (Key)
import Component.Container
import Component.Icons
import Component.Tabs
import Component.Theme
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Url exposing (Url)



-- MODEL


type alias Model =
    {}



-- FLAGS


type alias Flags =
    {}



-- MSG


type Msg
    = UrlChange Url
    | UrlRequest Browser.UrlRequest



-- INIT


init : Flags -> Url -> Key -> ( Model, Cmd Msg )
init flags url key =
    ( initialModel, Cmd.none )


initialModel : Model
initialModel =
    {}



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange _ ->
            ( model, Cmd.none )

        UrlRequest _ ->
            ( model, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    let
        tabs =
            [ { label = "Home", key = "home" }
            , { label = "Blog", key = "blog" }
            , { label = "About", key = "about" }
            ]
    in
    { title = "Seth Lowie"
    , body =
        [ Component.Container.app
            [ width fill
            , height fill
            ]
          <|
            row
                [ spaceEvenly
                , width fill
                , Component.Theme.padding 4
                , Border.widthEach
                    { top = 0
                    , right = 0
                    , left = 0
                    , bottom = 1
                    }
                ]
                [ el [ width fill ] <|
                    el [] <|
                        text "Seth Lowie"
                , el [ centerX ]
                    (Component.Tabs.config tabs
                        |> Component.Tabs.activeKey "home"
                        |> Component.Tabs.view
                    )
                , el [ width fill, alignTop ] <|
                    column [ alignRight 
                    , Component.Theme.spacing 1
                    , Font.size 14
                    ]
                        [ link [ alignLeft ]
                            { url = "https://github.com/sethlowie"
                            , label =
                                row [ Component.Theme.spacing 1 ]
                                    [ el
                                        []
                                      <|
                                        Component.Icons.github
                                    , text "github.com/sethlowie"
                                    ]
                            }
                        , link [ alignLeft ]
                            { url = "https://www.linkedin.com/in/slowie/"
                            , label =
                                row [ Component.Theme.spacing 1 ]
                                    [ el
                                        []
                                      <|
                                        Component.Icons.linkedin
                                    , text "linkedin.com"
                                    ]
                            }
                        ]
                ]
        ]
    }


main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChange
        }
