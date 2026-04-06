// ============================================================
// Chapter 02: 関数
// ============================================================
// 関数定義、型注釈、ラベル付き引数、無名関数、高階関数を学びます。
// ============================================================

import gleam/float
import gleam/int
import gleam/io
import gleam/order
import gleam/string

pub fn run() -> Nil {
  io.println("=== Chapter 02: 関数 ===")

  // ----------------------------------------------------------
  // 2-1. 基本的な関数定義
  // ----------------------------------------------------------
  // pub fn で公開関数、fn でプライベート関数
  io.println("add(3, 4) = " <> int.to_string(add(3, 4)))
  io.println("multiply(6, 7) = " <> int.to_string(multiply(6, 7)))

  // ----------------------------------------------------------
  // 2-2. 型注釈付きの関数
  // ----------------------------------------------------------
  io.println("greet(\"World\") = " <> greet("World"))

  // ----------------------------------------------------------
  // 2-3. ラベル付き引数
  // ----------------------------------------------------------
  // 呼び出し時にラベルを指定できるので、引数の意味が明確になる
  let result = divide(numerator: 10.0, denominator: 3.0)
  io.println("divide(10.0, 3.0) = " <> float.to_string(result))

  // ラベル付き引数は順序を入れ替え可能
  let result2 = divide(denominator: 4.0, numerator: 20.0)
  io.println("divide(20.0, 4.0) = " <> float.to_string(result2))

  // ----------------------------------------------------------
  // 2-4. 無名関数 (ラムダ) と関数キャプチャ
  // ----------------------------------------------------------
  // fn(引数) { 本体 } で無名関数を作成
  let double = fn(x: Int) -> Int { x * 2 }
  io.println("double(21) = " <> int.to_string(double(21)))

  let add_suffix = fn(s: String) -> String { s <> "!" }
  io.println("add_suffix(\"Hello\") = " <> add_suffix("Hello"))

  // _ を使った関数キャプチャ (部分適用)
  let add_ten = add(_, 10)
  io.println("add_ten(5) = " <> int.to_string(add_ten(5)))

  // ----------------------------------------------------------
  // 2-5. 高階関数 – 関数を引数に渡す
  // ----------------------------------------------------------
  io.println(
    "apply_twice(5, double) = " <> int.to_string(apply_twice(5, double)),
  )

  let increment = fn(x: Int) -> Int { x + 1 }
  io.println(
    "apply_twice(10, increment) = " <> int.to_string(apply_twice(10, increment)),
  )

  // ----------------------------------------------------------
  // 2-6. 関数を返す関数
  // ----------------------------------------------------------
  let adder = make_adder(100)
  io.println("make_adder(100)(42) = " <> int.to_string(adder(42)))

  // ----------------------------------------------------------
  // 2-7. 複数行の関数 – 最後の式が戻り値
  // ----------------------------------------------------------
  io.println("describe_number(0) = " <> describe_number(0))
  io.println("describe_number(5) = " <> describe_number(5))
  io.println("describe_number(-3) = " <> describe_number(-3))

  // ----------------------------------------------------------
  // TODO: 演習問題
  // ----------------------------------------------------------
  // 1. 2つの文字列を受け取り、スペースで結合して返す関数
  //    join_with_space を定義してください
  //
  // 2. ラベル付き引数 `from` と `to` を持つ関数 range_string を定義し、
  //    "from X to Y" という文字列を返してください
  //    例: range_string(from: 1, to: 10) => "from 1 to 10"

  io.println("")
}

// ----------------------------------------------------------
// 関数定義
// ----------------------------------------------------------

/// 2つの整数を足す
fn add(a: Int, b: Int) -> Int {
  a + b
}

/// 2つの整数を掛ける
fn multiply(a: Int, b: Int) -> Int {
  a * b
}

/// 挨拶メッセージを返す
fn greet(name: String) -> String {
  "Hello, " <> name <> "!"
}

/// ラベル付き引数で割り算
fn divide(numerator num: Float, denominator den: Float) -> Float {
  num /. den
}

/// 関数を2回適用する高階関数
fn apply_twice(value: Int, f: fn(Int) -> Int) -> Int {
  f(f(value))
}

/// 指定した数を足すクロージャを返す
fn make_adder(n: Int) -> fn(Int) -> Int {
  fn(x) { n + x }
}

/// 数値を説明する文字列を返す
fn describe_number(n: Int) -> String {
  // case は次の章で詳しく学びます
  case int.compare(n, 0) {
    order.Lt -> "negative: " <> int.to_string(n)
    order.Eq -> "zero"
    order.Gt -> "positive: " <> int.to_string(n)
  }
}
