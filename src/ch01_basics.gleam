// ============================================================
// Chapter 01: Hello World & 基本の型
// ============================================================
// Gleam の基本的な型とリテラル、変数バインディングを学びます。
//
// 実行: src/handson.gleam の main() から ch01_basics.run() を呼び出し
//       gleam run
// ============================================================

import gleam/float
import gleam/int
import gleam/io
import gleam/string

pub fn run() -> Nil {
  io.println("=== Chapter 01: Hello World & 基本の型 ===")

  // ----------------------------------------------------------
  // 1-1. Hello World
  // ----------------------------------------------------------
  // io.println は String を受け取って標準出力に表示します
  io.println("Hello, Gleam!")

  // ----------------------------------------------------------
  // 1-2. 整数 (Int)
  // ----------------------------------------------------------
  let age: Int = 30
  let negative = -5
  // Gleam では _ で桁区切りが可能
  let big_number = 1_000_000
  io.println("age = " <> int.to_string(age))
  io.println("negative = " <> int.to_string(negative))
  io.println("big_number = " <> int.to_string(big_number))

  // 基本的な算術演算
  let sum = 10 + 20
  let diff = 50 - 15
  let product = 6 * 7
  let quotient = 100 / 3
  // 整数の割り算 (端数切り捨て)
  let remainder = 100 % 3
  io.println("10 + 20 = " <> int.to_string(sum))
  io.println("50 - 15 = " <> int.to_string(diff))
  io.println("6 * 7 = " <> int.to_string(product))
  io.println("100 / 3 = " <> int.to_string(quotient))
  io.println("100 % 3 = " <> int.to_string(remainder))

  // ----------------------------------------------------------
  // 1-3. 浮動小数点数 (Float)
  // ----------------------------------------------------------
  let pi: Float = 3.14159
  let half = 0.5
  // Float の演算は +. -. *. /. を使う (Int の演算子とは別)
  let circle_area = pi *. 2.0 *. 2.0
  io.println("pi = " <> float.to_string(pi))
  io.println("half = " <> float.to_string(half))
  io.println("circle_area (r=2) = " <> float.to_string(circle_area))

  // ----------------------------------------------------------
  // 1-4. 文字列 (String)
  // ----------------------------------------------------------
  let greeting = "こんにちは"
  let name = "Gleam"
  // 文字列結合は <> 演算子
  let message = greeting <> "、" <> name <> "!"
  io.println(message)

  // string モジュールの便利関数
  io.println("長さ: " <> int.to_string(string.length(message)))
  io.println("大文字: " <> string.uppercase("hello"))
  io.println("反転: " <> string.reverse("abcde"))

  // ----------------------------------------------------------
  // 1-5. 真偽値 (Bool)
  // ----------------------------------------------------------
  let is_gleam_fun: Bool = True
  let is_mutable = False
  io.println("is_gleam_fun = " <> bool_to_string(is_gleam_fun))
  io.println("is_mutable = " <> bool_to_string(is_mutable))

  // 比較演算子
  let a = 10
  let b = 5
  io.println("10 > 5 = " <> bool_to_string(a > b))
  io.println("10 == 10 = " <> bool_to_string(a == 10))
  io.println("10 != 3 = " <> bool_to_string(a != 3))

  // ----------------------------------------------------------
  // 1-6. io.debug – 任意の値をデバッグ出力
  // ----------------------------------------------------------
  // io.debug はどんな型でも出力でき、値をそのまま返します
  io.println(string.inspect(#("tuple", 42, True)))

  // ----------------------------------------------------------
  // 1-7. let による変数の再バインディング
  // ----------------------------------------------------------
  // Gleam の変数は不変だが、同じ名前で再バインド (シャドーイング) は可能
  let x = 10
  io.println("x = " <> int.to_string(x))
  let x = x + 5
  io.println("x (re-bound) = " <> int.to_string(x))

  // ----------------------------------------------------------
  // TODO: 演習問題
  // ----------------------------------------------------------
  // 1. 自分の名前と年齢を変数に束縛し、
  //    「私は〇〇です。XX歳です。」と出力してみましょう
  // 2. 半径 5.0 の円の面積を計算して出力してみましょう
  //    (面積 = π × r × r)

  io.println("")
}

// ヘルパー: Bool を String に変換
fn bool_to_string(b: Bool) -> String {
  case b {
    True -> "True"
    False -> "False"
  }
}
