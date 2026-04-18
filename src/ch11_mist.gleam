import gleam/bytes_builder
import gleam/erlang/process
import gleam/http/request.{type Request}
import gleam/http/response.{type Response}
import gleam/io
import mist

pub fn run() {
  io.println("--- Chapter 11: Webサーバー (Mist) ---")
  io.println("サーバーを起動します。http://localhost:8080 にアクセスしてください。")
  io.println("(Ctrl+C で停止できます)")

  let assert Ok(_) =
    mist.new(fn(req: Request(mist.Connection)) -> Response(mist.ResponseData) {
      case request.path_segments(req) {
        [] -> {
          response.new(200)
          |> response.set_body(mist.Bytes(bytes_builder.from_string("Welcome to Gleam Hands-on!")))
        }
        ["hello"] -> {
          response.new(200)
          |> response.set_body(mist.Bytes(bytes_builder.from_string("Hello from Mist!")))
        }
        _ -> {
          response.new(404)
          |> response.set_body(mist.Bytes(bytes_builder.from_string("Not Found")))
        }
      }
    })
    |> mist.port(8080)
    |> mist.start_http

  // サーバーを動作させ続けるためにメインプロセスをスリープさせます
  process.sleep_forever()
}
