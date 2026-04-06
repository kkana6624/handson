// ============================================================
// Chapter 05: リスト & イテレーション
// ============================================================
// Gleam のリスト型と、list モジュールによる関数的な操作を学びます。
// ============================================================

import gleam/int
import gleam/io
import gleam/list
import gleam/string

pub fn run() -> Nil {
  io.println("=== Chapter 05: リスト & イテレーション ===")

  // ----------------------------------------------------------
  // 5-1. リストリテラル
  // ----------------------------------------------------------
  let numbers = [1, 2, 3, 4, 5]
  let names = ["Alice", "Bob", "Charlie"]
  let empty: List(Int) = []

  io.println(string.inspect(numbers))
  io.println(string.inspect(names))
  io.println(string.inspect(empty))

  // ----------------------------------------------------------
  // 5-2. リストの先頭に要素を追加
  // ----------------------------------------------------------
  let more_numbers = [0, ..numbers]
  io.println(string.inspect(more_numbers))
  // [0, 1, 2, 3, 4, 5]

  // ----------------------------------------------------------
  // 5-3. list.map – 各要素を変換
  // ----------------------------------------------------------
  let doubled = list.map(numbers, fn(n) { n * 2 })
  io.println("doubled: " <> debug_int_list(doubled))

  let uppercased = list.map(names, string.uppercase)
  io.println(string.inspect(uppercased))

  // ----------------------------------------------------------
  // 5-4. list.filter – 条件に合う要素だけ残す
  // ----------------------------------------------------------
  let evens = list.filter(numbers, fn(n) { n % 2 == 0 })
  io.println("evens: " <> debug_int_list(evens))

  // ----------------------------------------------------------
  // 5-5. list.fold – 畳み込み (集約)
  // ----------------------------------------------------------
  // fold(リスト, 初期値, fn(累積値, 要素) { ... })
  let total = list.fold(numbers, 0, fn(acc, n) { acc + n })
  io.println("sum of [1..5] = " <> int.to_string(total))

  // 文字列の結合にも使える
  let joined =
    list.fold(names, "", fn(acc, name) {
      case acc {
        "" -> name
        _ -> acc <> ", " <> name
      }
    })
  io.println("joined: " <> joined)

  // ----------------------------------------------------------
  // 5-6. list.each – 副作用のためのイテレーション
  // ----------------------------------------------------------
  io.println("--- list.each ---")
  list.each(names, fn(name) { io.println("  Hello, " <> name <> "!") })

  // ----------------------------------------------------------
  // 5-7. list.find – 条件に合う最初の要素を検索
  // ----------------------------------------------------------
  let found = list.find(numbers, fn(n) { n > 3 })
  io.println(string.inspect(#("find > 3", found)))
  // Ok(4)

  let not_found = list.find(numbers, fn(n) { n > 100 })
  io.println(string.inspect(#("find > 100", not_found)))
  // Error(Nil)

  // ----------------------------------------------------------
  // 5-8. リストのパターンマッチ
  // ----------------------------------------------------------
  io.println("--- パターンマッチ ---")
  describe_list([])
  describe_list([42])
  describe_list([1, 2])
  describe_list([1, 2, 3, 4, 5])

  // ----------------------------------------------------------
  // 5-9. その他の便利な関数
  // ----------------------------------------------------------
  io.println("length: " <> int.to_string(list.length(numbers)))
  io.println("reverse: " <> debug_int_list(list.reverse(numbers)))
  io.println(string.inspect(#("contains 3?", list.contains(numbers, 3))))
  io.println(string.inspect(#("first", list.first(numbers))))
  io.println(string.inspect(#("rest", list.rest(numbers))))

  // list.sort
  let unsorted = [3, 1, 4, 1, 5, 9, 2, 6]
  let sorted = list.sort(unsorted, int.compare)
  io.println("sorted: " <> debug_int_list(sorted))

  // list.zip – 2つのリストを組にする
  let keys = ["a", "b", "c"]
  let values = [1, 2, 3]
  io.println(string.inspect(list.zip(keys, values)))

  // ----------------------------------------------------------
  // TODO: 演習問題
  // ----------------------------------------------------------
  // 1. [10, 20, 30, 40, 50] から 25 以上の要素だけを抽出し、
  //    各要素を2倍にしたリストを作成してください
  //    (filter → map のチェーン)
  //
  // 2. 文字列のリスト ["Gleam", "is", "fun"] を受け取り、
  //    各単語の文字数のリスト [5, 2, 3] を返す関数を作ってください
  //
  // 3. list.fold を使って、整数リストの最大値を求める関数
  //    max_of_list を実装してください

  io.println("")
}

/// リストの内容を説明する
fn describe_list(items: List(Int)) -> Nil {
  case items {
    [] -> io.println("  空のリスト")
    [only] -> io.println("  要素1つ: " <> int.to_string(only))
    [first, ..rest] ->
      io.println(
        "  先頭: "
        <> int.to_string(first)
        <> ", 残り "
        <> int.to_string(list.length(rest))
        <> " 個",
      )
  }
}

/// Int リストをデバッグ用文字列に変換
fn debug_int_list(items: List(Int)) -> String {
  let inner =
    list.map(items, int.to_string)
    |> string.join(", ")
  "[" <> inner <> "]"
}
