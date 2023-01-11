module Main exposing (main)

import Blog
import Browser
import Browser.Navigation as Nav exposing (Key)
import Component.Container
import Component.Icons
import Component.Tabs
import Component.Theme
import Element exposing (..)
import Element.Border as Border
import Element.Font as Font
import Routes
import Url exposing (Url)
import Url.Parser exposing (parse)



-- MODEL


type alias Model =
    { route : Routes.Route
    , navKey : Key
    , blogModel : Blog.Model
    }



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
    let
        route =
            Maybe.withDefault Routes.NotFound <|
                parse Routes.route url
    in
    ( initialModel route key, Cmd.none )


initialModel : Routes.Route -> Key -> Model
initialModel route key =
    { route = route
    , navKey = key
    , blogModel = Blog.init
    }



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange url ->
            let
                route =
                    Maybe.withDefault Routes.NotFound <|
                        parse Routes.route url
            in
            ( { model | route = route }, Cmd.none )

        UrlRequest urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.navKey <| Url.toString url
                    )

                Browser.External href ->
                    ( model, Nav.load href )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Seth Lowie"
    , body =
        [ Component.Container.app
            [ width fill
            , height fill
            , scrollbars
            ]
          <|
            column
                [ width fill
                , height fill
                , scrollbars
                ]
                [ appBar model.route
                , el
                    [ width fill
                    , height fill
                    , scrollbars
                    , Component.Theme.padding 4
                    ]
                  <|
                    case model.route of
                        Routes.Home ->
                            text "Home"

                        Routes.Blog ->
                            Blog.view model.blogModel

                        Routes.About ->
                            text "About"

                        Routes.NotFound ->
                            text "Not Found"
                ]
        ]
    }


appBar : Routes.Route -> Element Msg
appBar route =
    let
        tabs =
            [ { label = "Home", key = "home", href = "/" }
            , { label = "Blog", key = "blog", href = "/blog" }
            , { label = "About", key = "about", href = "/about" }
            ]
    in
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
                |> Component.Tabs.activeKey (Routes.toString route)
                |> Component.Tabs.view
            )
        , el [ width fill, alignTop ] <|
            column
                [ alignRight
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


main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequest
        , onUrlChange = UrlChange
        }
