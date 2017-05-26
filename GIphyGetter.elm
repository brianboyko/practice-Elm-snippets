-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/http.html

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode



main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { topic : String
  , gifUrl : String
  , errMsg : String
  }

init : (Model, Cmd Msg)
init =
  (Model "cats" "waiting.gif" "", Cmd.none)


-- UPDATE

type Msg = 
  MorePlease
  | NewGif (Result Http.Error String)
  | ChangeTopic String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of

    MorePlease ->
      (model, getRandomGif model.topic)
      
    ChangeTopic newTopic -> 
      ({model | topic = newTopic}, Cmd.none)
      
    NewGif (Ok newUrl) -> 
      ( {model | gifUrl = newUrl, errMsg = "" }, Cmd.none )
      
    NewGif (Err errTxt) -> 
      ({ model | errMsg = (toString errTxt)} , Cmd.none)


getRandomGif : String -> Cmd Msg
getRandomGif topic = 
  let 
    url = "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
    
    request = 
      Http.get url decodeGifURL
  in
    Http.send NewGif request
    
decodeGifURL : Decode.Decoder String
decodeGifURL = 
  Decode.at ["data", "image_url"] Decode.string

-- Subscriptions

subscriptions: Model -> Sub Msg
subscriptions model = 
  Sub.none
  
-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text model.topic]
    , input [ type_ "text", placeholder "Topic", onInput ChangeTopic] []
    , img [src model.gifUrl] []
    , button [ onClick MorePlease ] [ text "More Please!" ]
    , select [ onInput ChangeTopic ]
              [ option [ value "cats" ] [ text "cats" ]
              , option [ value "dogs" ] [ text "dogs" ]
              , option [ value "humans" ] [ text "humans" ]
              ]
      
    ]
    
    
errorShow : String -> Html Msg
errorShow e = 
  case e of
    "" -> div [] []
    _  -> div [] [ text e ]   