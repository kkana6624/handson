// ============================================================
// Chapter 09: ジェネリクス
// ============================================================
// 型パラメータ (ジェネリクス) を使って汎用的な関数や型を定義します。
// ============================================================

import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub fn run() -> Nil {
  io.println("=== Chapter 09: ジェネリクス ===")

  // ----------------------------------------------------------
  // 9-1. ジェネリック関数
  // ----------------------------------------------------------
  // 型パラメータ a, b, ... を使って任意の型で動く関数を作る
  io.println(string.inspect(identity(42)))
  // 42
  io.println(string.inspect(identity("hello")))
  // "hello"
  io.println(string.inspect(identity(True)))
  // True

  // ----------------------------------------------------------
  // 9-2. Pair – ジェネリックなカスタム型
  // ----------------------------------------------------------
  let pair1 = Pair("name", 42)
  let pair2 = Pair(1, True)

  io.println(string.inspect(pair1))
  io.println(string.inspect(pair2))

  // フィールドアクセス
  io.println("pair1.first = " <> pair1.first)
  io.println("pair1.second = " <> int.to_string(pair1.second))

  // ----------------------------------------------------------
  // 9-3. ジェネリック関数でペアを操作
  // ----------------------------------------------------------
  let swapped = swap(pair1)
  io.println(string.inspect(#("swapped", swapped)))
  // Pair(42, "name")

  let mapped = map_second(pair1, fn(n) { n * 2 })
  io.println(string.inspect(#("map_second", mapped)))
  // Pair("name", 84)

  // ----------------------------------------------------------
  // 9-4. Box 型 – ラッパー
  // ----------------------------------------------------------
  let boxed_int = Box(42)
  let boxed_str = Box("hello")

  io.println("boxed_int: " <> int.to_string(unbox(boxed_int)))
  io.println("boxed_str: " <> unbox(boxed_str))

  // Box の中身を変換
  let doubled_box = map_box(boxed_int, fn(n) { n * 2 })
  io.println("doubled_box: " <> int.to_string(unbox(doubled_box)))

  // ----------------------------------------------------------
  // 9-5. Stack 型 – ジェネリックなデータ構造
  // ----------------------------------------------------------
  let stack =
    new_stack()
    |> push(1)
    |> push(2)
    |> push(3)

  io.println(string.inspect(#("stack", stack)))

  case pop(stack) {
    Ok(#(value, rest)) -> {
      io.println("popped: " <> int.to_string(value))
      io.println(string.inspect(#("remaining", rest)))
      Nil
    }
    Error(_) -> {
      io.println("stack is empty")
      Nil
    }
  }

  // ----------------------------------------------------------
  // 9-6. ジェネリクスと list の組み合わせ
  // ----------------------------------------------------------
  // list モジュールの関数は全てジェネリック
  let int_list = [3, 1, 4, 1, 5]
  let str_list = ["Gleam", "is", "great"]

  // 同じ list.map が Int にも String にも使える
  io.println(string.inspect(list.map(int_list, fn(n) { n * 10 })))
  io.println(string.inspect(list.map(str_list, string.uppercase)))

  // 自作のジェネリック関数
  io.println(
    string.inspect(#("first_or_default int", first_or_default(int_list, 0))),
  )
  io.println(
    string.inspect(#("first_or_default str", first_or_default(str_list, "???"))),
  )
  io.println(
    string.inspect(#("first_or_default empty", first_or_default([], "default"))),
  )

  // ----------------------------------------------------------
  // TODO: 演習問題
  // ----------------------------------------------------------
  // 1. ジェネリックな関数 apply(value: a, f: fn(a) -> b) -> b
  //    を実装してください
  //
  // 2. ジェネリック型 Maybe(a) を以下のように定義し、
  //    map_maybe(maybe: Maybe(a), f: fn(a) -> b) -> Maybe(b)
  //    を実装してください
  //    type Maybe(a) { Just(a)  Nothing }
  //
  // 3. Stack に peek (先頭を見るだけで取り出さない) 関数を追加してください

  io.println("")
}

// =============================================================
// ジェネリックな関数・型の定義
// =============================================================

/// 恒等関数 – 受け取った値をそのまま返す
pub fn identity(value: a) -> a {
  value
}

/// ジェネリックなペア型
pub type Pair(a, b) {
  Pair(first: a, second: b)
}

/// ペアの要素を入れ替える
pub fn swap(pair: Pair(a, b)) -> Pair(b, a) {
  Pair(first: pair.second, second: pair.first)
}

/// ペアの2つ目の要素を関数で変換する
pub fn map_second(pair: Pair(a, b), f: fn(b) -> c) -> Pair(a, c) {
  Pair(first: pair.first, second: f(pair.second))
}

/// ジェネリックな Box (ラッパー) 型
pub type Box(a) {
  Box(value: a)
}

/// Box の中身を取り出す
pub fn unbox(box: Box(a)) -> a {
  box.value
}

/// Box の中身を変換する
pub fn map_box(box: Box(a), f: fn(a) -> b) -> Box(b) {
  Box(f(box.value))
}

/// ジェネリックな Stack 型
pub type Stack(a) {
  Stack(items: List(a))
}

/// 空のスタックを作る
pub fn new_stack() -> Stack(a) {
  Stack(items: [])
}

/// スタックに値を積む
pub fn push(stack: Stack(a), value: a) -> Stack(a) {
  Stack(items: [value, ..stack.items])
}

/// スタックから値を取り出す
pub fn pop(stack: Stack(a)) -> Result(#(a, Stack(a)), Nil) {
  case stack.items {
    [] -> Error(Nil)
    [first, ..rest] -> Ok(#(first, Stack(items: rest)))
  }
}

/// リストの先頭要素を返す。空ならデフォルト値を返す
pub fn first_or_default(items: List(a), default: a) -> a {
  case items {
    [] -> default
    [first, ..] -> first
  }
}
