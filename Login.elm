import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
  Html.beginnerProgram { model = model, view = view, update = update }

-- MODEL

type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  }

model : Model
model = 
  Model "" "" "" 

-- UPDATE

type Msg
  = Name String
  | Password String
  | PasswordAgain String

update : Msg -> Model -> Model
update msg model = 
  case msg of
    Name name ->
      { model | name = name }
      
    Password password -> 
      { model | password = password }
  
    PasswordAgain password ->
      { model | passwordAgain = password }




-- VIEW

view : Model -> Html Msg
view model = 
  div []
    [ input [ type_ "text", placeholder "Name", onInput Name] []
    , input [ type_ "password", placeholder "Password", onInput Password ] []
    , input [ type_ "password", placeholder "Re-enter password", onInput PasswordAgain ] []
    , viewValidation model
    ]


    
viewValidation : Model -> Html msg
viewValidation model = 
  let 
    (color, message) =
      if model.password != model.passwordAgain then
        ("red", "Passwords do not match!")
      else if String.length model.password < 8 then
        ("red", "Password must be 8 or more characters")
      else if String.any Char.isUpper model.password == false then
        ("red", "Password must contain an uppercase character")
      else if String.any Char.isLower model.password == false then
        ("red", "Password must contain a lowercase character")
      else if String.any Char.isDigit model.password == false then
        ("red", "Password must contain a digit")
      else 
        ("green", "OK")
      
  in
    div [ style [("color", color)] ] [ text message ]

