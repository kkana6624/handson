// ============================================================
// Chapter 04: カスタム型 (type / enum)
// ============================================================
// Gleam の type キーワードでレコード型・バリアント型を定義します。
// ============================================================

import gleam/float
import gleam/int
import gleam/io

// ----------------------------------------------------------
// 4-1. レコード型 (単一バリアント)
// ----------------------------------------------------------
// フィールドにラベルを付けた構造体のような型
pub type User {
  User(name: String, age: Int, email: String)
}

// ----------------------------------------------------------
// 4-2. バリアント型 (複数コンストラクタ = enum 的)
// ----------------------------------------------------------
pub type Color {
  Red
  Green
  Blue
  Custom(r: Int, g: Int, b: Int)
}

// ----------------------------------------------------------
// 4-3. より実用的なバリアント型
// ----------------------------------------------------------
pub type Shape {
  Circle(radius: Float)
  Rectangle(width: Float, height: Float)
  Triangle(base: Float, height: Float)
}

pub fn run() -> Nil {
  io.println("=== Chapter 04: カスタム型 ===")

  // ----------------------------------------------------------
  // レコード型の使用
  // ----------------------------------------------------------
  let user = User(name: "Alice", age: 30, email: "alice@example.com")
  io.println("名前: " <> user.name)
  io.println("年齢: " <> int.to_string(user.age))
  io.println("メール: " <> user.email)

  // レコードの更新 (スプレッド構文)
  // 既存のレコードを元に一部フィールドを変更した新しいレコードを作る
  let older_user = User(..user, age: 31)
  io.println("誕生日後の年齢: " <> int.to_string(older_user.age))

  // ----------------------------------------------------------
  // バリアント型の使用
  // ----------------------------------------------------------
  let my_color = Custom(r: 255, g: 128, b: 0)
  io.println("色: " <> color_to_string(my_color))
  io.println("赤: " <> color_to_string(Red))

  // ----------------------------------------------------------
  // Shape の面積計算
  // ----------------------------------------------------------
  let _shapes = [
    Circle(radius: 5.0),
    Rectangle(width: 4.0, height: 6.0),
    Triangle(base: 3.0, height: 8.0),
  ]

  // 各図形の面積を表示
  display_shape(Circle(radius: 5.0))
  display_shape(Rectangle(width: 4.0, height: 6.0))
  display_shape(Triangle(base: 3.0, height: 8.0))

  // ----------------------------------------------------------
  // 4-4. パターンマッチとの組み合わせ
  // ----------------------------------------------------------
  let user2 = User(name: "Bob", age: 17, email: "bob@example.com")
  io.println(user_status(user))
  io.println(user_status(user2))

  // ----------------------------------------------------------
  // TODO: 演習問題
  // ----------------------------------------------------------
  // 1. 以下の型 Animal を定義してください:
  //    - Dog(name: String, breed: String)
  //    - Cat(name: String, indoor: Bool)
  //    - Fish(species: String)
  //
  // 2. Animal を受け取り、説明文を返す関数
  //    describe_animal を実装してください
  //    例: Dog("Pochi", "Shiba") → "犬のPochi (柴犬)"

  io.println("")
}

/// Color を文字列に変換
fn color_to_string(color: Color) -> String {
  case color {
    Red -> "Red"
    Green -> "Green"
    Blue -> "Blue"
    Custom(r, g, b) ->
      "RGB("
      <> int.to_string(r)
      <> ", "
      <> int.to_string(g)
      <> ", "
      <> int.to_string(b)
      <> ")"
  }
}

/// Shape の面積を計算
pub fn area(shape: Shape) -> Float {
  case shape {
    Circle(radius:) -> 3.14159 *. radius *. radius
    Rectangle(width:, height:) -> width *. height
    Triangle(base:, height:) -> 0.5 *. base *. height
  }
}

/// Shape を表示
fn display_shape(shape: Shape) -> Nil {
  let name = case shape {
    Circle(..) -> "円"
    Rectangle(..) -> "長方形"
    Triangle(..) -> "三角形"
  }
  io.println(name <> " の面積: " <> float.to_string(area(shape)))
}

/// ユーザーの状態を返す
fn user_status(user: User) -> String {
  case user {
    User(name:, age:, ..) if age >= 18 -> name <> " は成人です"
    User(name:, ..) -> name <> " は未成年です"
  }
}
