module Main exposing (..)

import Html.App as App
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (class, style)
import Geolocation exposing (changes)


main : Program Never
main =
  App.program
    { init = initModel
    , update = update
    , view = view
    , subscriptions = subscriptions
    }

-- subscriptions
subscriptions : a -> Sub Msg
subscriptions model =
  let
    changeFn loc = Echo <| "lat: " ++ (toString loc.latitude) ++ "  lng: " ++ (toString loc.latitude) ++ "  timestamp: " ++ (toString loc.timestamp)
  in
    changes changeFn

-- model

type alias Model = {count: Int, msg: String}

model : Model
model = {count = 1, msg = "started"}

initModel : (Model, Cmd a)
initModel = (model, Cmd.none)

-- update

type Msg
  = Increment
  | Decrement
  | Echo String

update : Msg -> Model -> (Model, Cmd a)
update msg model =
  case msg of
    Increment ->
      ({model | count = model.count + 1}, Cmd.none)
    Decrement ->
      ({model | count = model.count - 1}, Cmd.none)
    Echo str ->
      ({model | msg = str }, Cmd.none)


-- view

view : Model -> Html Msg
view model =
  div [ class "ionic" ]
    [ header
    , contentContainer (content model)
    ]

content : Model -> Html Msg
content model =
  div [ class "list list-inset" ]
    [ div [ class "row", style [("text-align", "center")] ]
      [ div [ class "col" ] [ button [ onClick Decrement, class "button" ] [ text "-" ] ]
      , div [ class "col col-center col-50"  ] [ text (toString model.count) ]
      , div [ class "col" ] [  button [ onClick Increment, class "button" ] [ text "+" ] ]
      ]
      , msgDiv model
    ]

msgDiv : Model -> Html Msg
msgDiv model =
  div [ class "row", style [("text-align", "center")] ]
  [ div [ class "col col-center col-100"  ] [ text model.msg ] ]

contentContainer : Html a -> Html a
contentContainer inside =
  div [ class "scroll-content ionic-scroll has-header scroll-content-false" ]
    [ inside ]

header : Html a
header =
  div [ class "bar bar-header bar-positive" ]
    [ h1 [ class "title" ] [ text "Counter.elm" ]
    ]

