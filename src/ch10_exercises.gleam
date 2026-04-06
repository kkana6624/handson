// ============================================================
// Chapter 10: 総合演習 – FizzBuzz & 簡易スタック
// ============================================================
// これまで学んだ文法を総合的に使って、実践的な課題に取り組みます。
// ============================================================

import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub fn run() -> Nil {
  io.println("=== Chapter 10: 総合演習 ===")

  // ----------------------------------------------------------
  // 演習 1: FizzBuzz
  // ----------------------------------------------------------
  io.println("--- FizzBuzz (1〜30) ---")
  fizzbuzz(30)

  // ----------------------------------------------------------
  // 演習 2: 簡易スタック (解答例)
  // ----------------------------------------------------------
  io.println("")
  io.println("--- Stack デモ ---")
  demo_stack()

  // ----------------------------------------------------------
  // 演習 3: 単語カウンター
  // ----------------------------------------------------------
  io.println("")
  io.println("--- 単語カウンター ---")
  let text = "gleam is fun gleam is great gleam gleam fun"
  let counts = word_count(text)
  io.println(string.inspect(counts))

  // ----------------------------------------------------------
  // 演習 4: 自分で挑戦! (TODO)
  // ----------------------------------------------------------
  // 以下の課題に挑戦してみましょう:
  //
  // A. フィボナッチ数列の最初の N 個を返す関数 fibonacci(n: Int) -> List(Int)
  //    例: fibonacci(8) => [0, 1, 1, 2, 3, 5, 8, 13]
  //
  // B. 文字列のリストを受け取り、最も長い文字列を返す関数
  //    longest(strings: List(String)) -> Result(String, Nil)
  //
  // C. 簡易的な Caesar 暗号:
  //    - encrypt(text: String, shift: Int) -> String
  //    - decrypt(text: String, shift: Int) -> String
  //    (英小文字のみ対応で OK)

  io.println("")
}

// =============================================================
// 演習 1: FizzBuzz 実装
// =============================================================

/// 1 から n までの FizzBuzz を出力
pub fn fizzbuzz(n: Int) -> Nil {
  make_range(1, n)
  |> list.map(fizzbuzz_value)
  |> list.each(io.println)
}

/// 数値に対応する FizzBuzz の文字列を返す
pub fn fizzbuzz_value(n: Int) -> String {
  case n % 3, n % 5 {
    0, 0 -> "FizzBuzz"
    0, _ -> "Fizz"
    _, 0 -> "Buzz"
    _, _ -> int.to_string(n)
  }
}

// =============================================================
// 演習 2: 簡易スタック (再実装 + 追加機能)
// =============================================================

/// スタック型
pub type IntStack {
  IntStack(items: List(Int))
}

/// 空のスタック
pub fn new_int_stack() -> IntStack {
  IntStack(items: [])
}

/// push
pub fn int_stack_push(stack: IntStack, value: Int) -> IntStack {
  IntStack(items: [value, ..stack.items])
}

/// pop
pub fn int_stack_pop(stack: IntStack) -> Result(#(Int, IntStack), String) {
  case stack.items {
    [] -> Error("スタックが空です")
    [top, ..rest] -> Ok(#(top, IntStack(items: rest)))
  }
}

/// peek (取り出さずに先頭を見る)
pub fn int_stack_peek(stack: IntStack) -> Result(Int, String) {
  case stack.items {
    [] -> Error("スタックが空です")
    [top, ..] -> Ok(top)
  }
}

/// スタックのサイズ
pub fn int_stack_size(stack: IntStack) -> Int {
  list.length(stack.items)
}

/// スタックが空か判定
pub fn int_stack_is_empty(stack: IntStack) -> Bool {
  stack.items == []
}

/// スタックのデモ
fn demo_stack() -> Nil {
  let stack =
    new_int_stack()
    |> int_stack_push(10)
    |> int_stack_push(20)
    |> int_stack_push(30)

  io.println("size: " <> int.to_string(int_stack_size(stack)))
  io.println(string.inspect(#("peek", int_stack_peek(stack))))

  case int_stack_pop(stack) {
    Ok(#(value, remaining)) -> {
      io.println("popped: " <> int.to_string(value))
      io.println("remaining size: " <> int.to_string(int_stack_size(remaining)))
    }
    Error(msg) -> io.println("Error: " <> msg)
  }
}

// =============================================================
// 演習 3: 単語カウンター
// =============================================================

/// テキスト中の各単語の出現回数を返す
pub fn word_count(text: String) -> List(#(String, Int)) {
  text
  |> string.split(" ")
  |> list.fold([], fn(acc, word) {
    case find_and_increment(acc, word) {
      Ok(updated) -> updated
      Error(_) -> [#(word, 1), ..acc]
    }
  })
  |> list.sort(fn(a, b) { int.compare(b.1, a.1) })
}

/// アキュムレータ内の単語を探してカウントを +1 する
fn find_and_increment(
  counts: List(#(String, Int)),
  target: String,
) -> Result(List(#(String, Int)), Nil) {
  case list.any(counts, fn(pair) { pair.0 == target }) {
    True ->
      Ok(
        list.map(counts, fn(pair) {
          case pair.0 == target {
            True -> #(pair.0, pair.1 + 1)
            False -> pair
          }
        }),
      )
    False -> Error(Nil)
  }
}

/// from から to までの整数リストを生成
fn make_range(from: Int, to: Int) -> List(Int) {
  case from > to {
    True -> []
    False -> [from, ..make_range(from + 1, to)]
  }
}
