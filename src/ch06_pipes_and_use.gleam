// ============================================================
// Chapter 06: パイプライン & use 式
// ============================================================
// パイプ演算子 |> と use 式を使った Gleam らしいコードの書き方を学びます。
// ============================================================

import gleam/int
import gleam/io
import gleam/list
import gleam/result
import gleam/string

pub fn run() -> Nil {
  io.println("=== Chapter 06: パイプライン & use 式 ===")

  // ----------------------------------------------------------
  // 6-1. パイプ演算子 |> の基本
  // ----------------------------------------------------------
  // f(g(h(x))) と書く代わりに x |> h |> g |> f と書ける
  // 左辺の値が右辺の関数の「第1引数」として渡される

  // パイプなし (読みにくい)
  let result_without_pipe = string.uppercase(string.reverse("hello"))
  io.println("パイプなし: " <> result_without_pipe)

  // パイプあり (読みやすい)
  let result_with_pipe =
    "hello"
    |> string.reverse
    |> string.uppercase
  io.println("パイプあり: " <> result_with_pipe)

  // ----------------------------------------------------------
  // 6-2. パイプで複数引数の関数を呼ぶ
  // ----------------------------------------------------------
  // 第2引数以降がある場合は fn(_, arg2, ...) として部分適用する
  let padded =
    "42"
    |> string.pad_start(5, "0")
  io.println("padded: " <> padded)
  // "00042"

  // ----------------------------------------------------------
  // 6-3. パイプチェーンの実用例
  // ----------------------------------------------------------
  let sentence = "  Hello, Gleam World!  "
  let processed =
    sentence
    |> string.trim
    |> string.lowercase
    |> string.replace(",", "")
    |> string.split(" ")
  io.println(string.inspect(processed))
  // ["hello", "gleam", "world!"]

  // 数値処理のチェーン
  let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
  let result =
    numbers
    |> list.filter(fn(n) { n % 2 == 0 })
    // 偶数だけ
    |> list.map(fn(n) { n * n })
    // 二乗
    |> list.fold(0, fn(acc, n) { acc + n })
  // 合計
  io.println("偶数の二乗の合計: " <> int.to_string(result))
  // 4 + 16 + 36 + 64 + 100 = 220

  // ----------------------------------------------------------
  // 6-4. use 式 – コールバックの簡略化
  // ----------------------------------------------------------
  // use はコールバック関数をフラットに書くための構文糖衣
  //
  // 通常のコールバック:
  //   result.try(parse_int("42"), fn(n) {
  //     result.try(parse_int("8"), fn(m) {
  //       Ok(n + m)
  //     })
  //   })
  //
  // use を使うと:
  //   use n <- result.try(parse_int("42"))
  //   use m <- result.try(parse_int("8"))
  //   Ok(n + m)

  // 例: list.each を use で書く
  io.println("--- use + list.each ---")
  use name <- list.each(["Alice", "Bob", "Charlie"])
  io.println("  こんにちは、" <> name <> "さん!")
}
// ----------------------------------------------------------
// TODO: 演習問題
// ----------------------------------------------------------
// 1. 以下の処理をパイプラインで書き直してください:
//    string.join(list.map(string.split("a,b,c,d", ","), string.uppercase), " | ")
//    期待出力: "A | B | C | D"
//
// 2. 1〜20 の整数リストから:
//    - 3の倍数だけ抽出
//    - 各要素を文字列に変換
//    - カンマで結合
//    をパイプラインで実装してください
