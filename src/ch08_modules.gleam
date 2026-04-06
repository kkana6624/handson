// ============================================================
// Chapter 08: モジュールとインポート
// ============================================================
// Gleam のモジュールシステム、pub による公開、import の使い方を学びます。
// ============================================================

import gleam/int
import gleam/io
import gleam/string

// ----------------------------------------------------------
// 8-1. import の基本
// ----------------------------------------------------------
// import モジュール名
// でモジュールを読み込み、モジュール名.関数名 で呼び出す
//
// 例: import gleam/string
//     string.length("hello")

// ----------------------------------------------------------
// 8-2. 型・関数の直接インポート
// ----------------------------------------------------------
// import gleam/option.{type Option, Some, None}
// と書くと Option, Some, None をプレフィックスなしで使える
import gleam/option.{type Option, None, Some}

// ----------------------------------------------------------
// 8-3. エイリアス (as)
// ----------------------------------------------------------
// import gleam/string as str
// と書くと str.length("hello") のように短い名前で使える
import gleam/string as str

// ----------------------------------------------------------
// 8-4. 自作モジュールのインポート
// ----------------------------------------------------------
// src/ch04_custom_types.gleam に定義した pub な型や関数を使う
import ch04_custom_types.{type Shape, Circle, Rectangle, Triangle}

pub fn run() -> Nil {
  io.println("=== Chapter 08: モジュールとインポート ===")

  // ----------------------------------------------------------
  // エイリアスの使用
  // ----------------------------------------------------------
  let msg = "Hello, Modules!"
  io.println("length: " <> int.to_string(str.length(msg)))
  io.println("upper: " <> str.uppercase(msg))

  // ----------------------------------------------------------
  // 直接インポートした型の使用
  // ----------------------------------------------------------
  let maybe_name: Option(String) = Some("Gleam")
  case maybe_name {
    Some(name) -> io.println("名前: " <> name)
    None -> io.println("名前なし")
  }

  // ----------------------------------------------------------
  // 自作モジュールの型を使用
  // ----------------------------------------------------------
  let _shapes: List(Shape) = [
    Circle(radius: 3.0),
    Rectangle(width: 5.0, height: 2.0),
    Triangle(base: 4.0, height: 6.0),
  ]

  io.println("--- 自作モジュールの関数を呼び出し ---")
  // ch04_custom_types.area は pub なのでここから呼べる
  io.println(string.inspect(ch04_custom_types.area(Circle(radius: 3.0))))

  // ----------------------------------------------------------
  // 8-5. pub と非公開
  // ----------------------------------------------------------
  // pub fn  → 他のモジュールからアクセス可能
  // fn      → 同一モジュール内のみ (プライベート)
  // pub type → 型とコンストラクタを公開
  // pub opaque type → 型名のみ公開、コンストラクタは非公開
  io.println("public_greeting: " <> public_greeting("World"))
  // private_helper() はこのモジュール内でのみ呼べる
  io.println("(private helper result: " <> private_helper() <> ")")

  // ----------------------------------------------------------
  // 8-6. モジュール構成のベストプラクティス
  // ----------------------------------------------------------
  // - 1ファイル = 1モジュール (ファイルパスがモジュール名)
  // - src/user/model.gleam → import user/model
  // - 関連する型と関数を同じモジュールにまとめる
  // - pub は必要最小限に (内部実装は隠す)

  io.println("")
  // ----------------------------------------------------------
  // TODO: 演習問題
  // ----------------------------------------------------------
  // 1. src/math_utils.gleam を新規作成し、以下の pub 関数を定義:
  //    - square(n: Int) -> Int       … n の二乗を返す
  //    - is_positive(n: Int) -> Bool  … n > 0 かどうか
  //
  // 2. この ch08_modules.gleam から math_utils をインポートし、
  //    square(5) と is_positive(-3) を呼び出して結果を表示してください
}

/// 公開関数の例
pub fn public_greeting(name: String) -> String {
  "Hello, " <> name <> "! " <> private_helper()
}

/// 非公開関数の例
fn private_helper() -> String {
  "(from private helper)"
}
