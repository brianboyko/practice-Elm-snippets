import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)


main =
  Html.beginnerProgram { model = model, view = view, update = update }


-- MODEL

type alias Model = Int

model : Model
model =
  0


-- UPDATE

type Msg = Increment | Decrement | Double | Reset

update : Msg -> Model -> Model
update msg model =
  case msg of
    Increment ->
      model + 1

    Decrement ->
      model - 1

    Double ->
      model * 2
    
    Reset ->
      0


-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ div [] [ text (toString model) ]
    , div [] [ text ("squared" ++ toString (model * model)) ]
    , button [ onClick Decrement ] [ text "-" ]
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick Double ] [ text "x2" ]
    , button [ onClick Reset ] [ text "x0" ]
    ]