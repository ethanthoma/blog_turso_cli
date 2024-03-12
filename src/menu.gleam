import teashop/command
import teashop/event
import teashop/key
import gleam/list
import gleam/string

pub type Model {
  Model(choices: List(#(String)), cursor: Int)
}

pub fn view(model: Model) {
  let options =
    model.choices
    |> list.index_map(fn(element, index) {
      let #(name) = element
      let cursor = case model.cursor == index {
        True -> ">"
        False -> " "
      }
      cursor <> " " <> name
    })
    |> string.join("\n")

  let header = "Select option below:"
  let footer = "Press q to quit."

  [header, options, footer]
  |> string.join("\n\n")
}

pub fn update(model: Model, event) {
  case event {
    event.Key(key.Char("q")) | event.Key(key.Esc) -> #(model, command.quit())

    event.Key(key.Char("k")) | event.Key(key.Up) -> {
      let choices_len = list.length(model.choices)
      let cursor = case model.cursor == 0 {
        True -> choices_len - 1
        False -> model.cursor - 1
      }
      #(Model(..model, cursor: cursor), command.none())
    }

    event.Key(key.Char("j")) | event.Key(key.Down) -> {
      let choices_len = list.length(model.choices)
      let cursor = case model.cursor == { choices_len - 1 } {
        True -> 0
        False -> model.cursor + 1
      }
      #(Model(..model, cursor: cursor), command.none())
    }

    event.Key(key.Enter) | event.Key(key.Space) -> {
      let choices =
        list.index_map(model.choices, fn(element, _) {
          let #(name) = element
          #(name)
        })
      #(Model(..model, choices: choices), command.none())
    }
    _otherwise -> #(model, command.none())
  }
}
