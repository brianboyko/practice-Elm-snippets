-- Read more about this program in the official Elm guide:
-- https://guide.elm-lang.org/architecture/effects/random.html

import Html exposing (..)
import Html.Attributes exposing(src)
import Html.Events exposing (..)
import String exposing (repeat)
import Random

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }




-- MODEL

type alias Model = 
  { dieFaceA : Int
  , dieFaceB : Int
  }
  
init : (Model, Cmd Msg)
init = 
  (
    { dieFaceA = 1
    , dieFaceB = 1
    }
  , Cmd.none)
  
-- UPDATE

type Msg = 
  Roll
  | NewFace (Int, Int) 
  
update: Msg -> Model -> (Model, Cmd Msg)
update msg model = 
  case msg of 
    Roll -> 
      (model, Random.generate NewFace (Random.pair (Random.int 1 6) (Random.int 1 6)))     
    
    NewFace (a, b) -> 
      (Model a b, Cmd.none)
  

-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = 
  Sub.none

-- VIEW

view : Model -> Html Msg
view model = 
  div []
    [ h1 [] [ text (toString ( model.dieFaceA + model.dieFaceB ) ) ]
    , button [ onClick Roll ] [ text "Roll!" ] 
    , div []
      [ pips model.dieFaceA
      , text " + "
      , pips model.dieFaceB
      ]
    , img [src (imgPips model.dieFaceA) ] []
    , img [src (imgPips model.dieFaceB) ] []
    ]
 
pips : Int -> Html Msg
pips face =
  div []
    [ h2 [] [text (String.repeat face "*") ] 
    ]
    
imgPips : Int -> String
imgPips face =
  case face of 
    1 -> "https://upload.wikimedia.org/wikipedia/commons/2/2c/Alea_1.png"
    2 -> "https://upload.wikimedia.org/wikipedia/commons/b/b8/Alea_2.png"
    3 -> "https://upload.wikimedia.org/wikipedia/commons/2/2f/Alea_3.png"
    4 -> "https://upload.wikimedia.org/wikipedia/commons/8/8d/Alea_4.png"
    5 -> "https://upload.wikimedia.org/wikipedia/commons/5/55/Alea_5.png"
    6 -> "https://upload.wikimedia.org/wikipedia/commons/f/f4/Alea_6.png"
    _ -> "Error"