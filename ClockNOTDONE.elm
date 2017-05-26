import Html exposing (Html)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second, millisecond, inHours, inMinutes, inSeconds, inMilliseconds)



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }


-- MODEL

type alias Model = 
  { time: Time
  , stop: Bool
  }

init : (Model, Cmd Msg)
init =
  (0 False, Cmd.none)


-- UPDATE

type Msg
  = Tick Time


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Tick newTime ->
      if model.stop then
        (model, Cmd.none)
      else
        ({model | time = newTime}, Cmd.none)
    Stop trigger ->
      ({model | stop = (not model.stop)}, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Time.every millisecond Tick


-- VIEW

view : Model -> Html Msg
view model =
  let
    hourAngle = 
      turns (Time.inSeconds model.time)
    
    handXhour = 
      toString(50 + 40 * cos hourAngle)
      
    handYhour = 
      toString(50 + 40 * sin hourAngle)
      
    minAngle = 
      turns (Time.inHours model.time)
      
    handXmin =
      toString(50 + 40 * cos minAngle)
      
    handYmin = 
      toString(50 + 40 * sin minAngle)
      
    secAngle =
      turns (Time.inMinutes model.time)
      
    handXsec =
      toString (50 + 40 * cos secAngle)

    handYsec =
      toString (50 + 40 * sin secAngle)
  in
    div []
      [ svg [ viewBox "0 0 100 100", width "300px" ]
        [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
        , line [ x1 "50", y1 "50", x2 handXsec, y2 handYsec, stroke "#023963" ] []
        , line [ x1 "50", y1 "50", x2 handXmin, y2 handYmin, stroke "#999900" ] []
        , line [ x1 "50", y1 "50", x2 handXhour, y2 handYhour, stroke "#990000" ] []
        ]
      , button [ onClick Stop ] [ text "STOP" ]
      ]