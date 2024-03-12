import teashop
import teashop/command
import envoy
import gleam/io
import menu

const initial_model = menu.Model(
  cursor: 0,
  choices: [#("Add"), #("Update"), #("Remove")],
)

pub fn init(_) {
  #(initial_model, command.set_window_title("Blog Turso"))
}

fn check_turso_auth() {
  case envoy.get("TURSO_API_TOKEN") {
    Ok(_) -> io.println("Token set.")
    _ -> panic("TURSO_API_TOKEN needs to be set.")
  }
}

pub fn main() {
  check_turso_auth()
  let app = teashop.app(init, menu.update, menu.view)
  teashop.start(app, Nil)
}
