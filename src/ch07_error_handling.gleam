// ============================================================
// Chapter 07: Result / Option によるエラー処理
// ============================================================
// Gleam には例外がありません。代わりに Result 型と Option 型で
// エラーや値の不在を型安全に扱います。
// ============================================================

import gleam/int
import gleam/io
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/result
import gleam/string

pub fn run() -> Nil {
  io.println("=== Chapter 07: Result / Option によるエラー処理 ===")

  // ----------------------------------------------------------
  // 7-1. Result 型の基本
  // ----------------------------------------------------------
  // Result(value, error) は Ok(value) か Error(error) のどちらか
  let success: Result(Int, String) = Ok(42)
  let failure: Result(Int, String) = Error("何かが失敗しました")

  io.println(string.inspect(success))
  // Ok(42)

  io.println(string.inspect(failure))
  // Error("何かが失敗しました")

  // case でパターンマッチ
  case success {
    Ok(value) -> io.println("成功: " <> int.to_string(value))
    Error(msg) -> io.println("失敗: " <> msg)
  }

  // ----------------------------------------------------------
  // 7-2. Result を返す関数
  // ----------------------------------------------------------
  io.println(string.inspect(safe_divide(10, 3)))
  // Ok(3)

  io.println(string.inspect(safe_divide(10, 0)))
  // Error("ゼロ除算")

  io.println(string.inspect(parse_age("25")))
  // Ok(25)

  io.println(string.inspect(parse_age("abc")))
  // Error("不正な数値: abc")

  io.println(string.inspect(parse_age("-5")))
  // Error("年齢は正の数...")

  // ----------------------------------------------------------
  // 7-3. result.map – Ok の中身を変換
  // ----------------------------------------------------------
  let doubled =
    safe_divide(10, 2)
    |> result.map(fn(n) { n * 2 })
  io.println(string.inspect(#("result.map Ok", doubled)))
  // Ok(10)

  let doubled_err =
    safe_divide(10, 0)
    |> result.map(fn(n) { n * 2 })
  io.println(string.inspect(#("result.map Error", doubled_err)))
  // Error("ゼロ除算")

  // ----------------------------------------------------------
  // 7-4. result.try – Result のチェーン (flatMap)
  // ----------------------------------------------------------
  // result.try は Ok の場合に次の Result 関数を呼ぶ
  let chained =
    parse_age("25")
    |> result.try(fn(age) {
      case age >= 18 {
        True -> Ok("成人です (" <> int.to_string(age) <> "歳)")
        False -> Error("未成年です")
      }
    })
  io.println(string.inspect(#("chained", chained)))

  // ----------------------------------------------------------
  // 7-5. use + result.try のイディオム
  // ----------------------------------------------------------
  let calc_result = calculate("10", "3")
  io.println(string.inspect(#("calculate(10, 3)", calc_result)))

  let calc_error = calculate("10", "0")
  io.println(string.inspect(#("calculate(10, 0)", calc_error)))

  let calc_parse_error = calculate("abc", "3")
  io.println(string.inspect(#("calculate(abc, 3)", calc_parse_error)))

  // ----------------------------------------------------------
  // 7-6. result のユーティリティ関数
  // ----------------------------------------------------------
  // unwrap – デフォルト値付きで取り出す
  let val = result.unwrap(Ok(42), 0)
  io.println("unwrap Ok(42) = " <> int.to_string(val))

  let val2 = result.unwrap(Error("oops"), 0)
  io.println("unwrap Error = " <> int.to_string(val2))

  // is_ok, is_error
  io.println(string.inspect(#("is_ok(Ok(1))", result.is_ok(Ok(1)))))
  io.println(string.inspect(#("is_error(Error(1))", result.is_error(Error(1)))))

  // ----------------------------------------------------------
  // 7-7. Option 型
  // ----------------------------------------------------------
  // Option(a) = Some(a) | None
  // 値が存在するかもしれない場面で使う
  let some_val: Option(Int) = Some(42)
  let no_val: Option(Int) = None

  io.println(string.inspect(some_val))
  io.println(string.inspect(no_val))

  // Option をパターンマッチ
  case some_val {
    Some(v) -> io.println("値あり: " <> int.to_string(v))
    None -> io.println("値なし")
  }

  // Option の便利関数
  io.println("unwrap Some(42) = " <> int.to_string(option.unwrap(some_val, 0)))
  io.println("unwrap None = " <> int.to_string(option.unwrap(no_val, 0)))

  // ----------------------------------------------------------
  // 7-8. find で Option 的に使える Result
  // ----------------------------------------------------------
  let users = ["Alice", "Bob", "Charlie"]
  let found = list.find(users, fn(u) { u == "Bob" })
  io.println(string.inspect(#("find Bob", found)))

  let not_found = list.find(users, fn(u) { u == "Dave" })
  io.println(string.inspect(#("find Dave", not_found)))

  // ----------------------------------------------------------
  // TODO: 演習問題
  // ----------------------------------------------------------
  // 1. 文字列を受け取り、5文字以上なら Ok(文字列) 、
  //    それ未満なら Error("短すぎます") を返す関数
  //    validate_name を実装してください
  //
  // 2. validate_name と parse_age を組み合わせて、
  //    名前と年齢の文字列を受け取り Result(String, String) を返す
  //    関数 validate_user を use + result.try で実装してください
  //    成功時は "名前(XX歳)" という文字列を返す

  io.println("")
}

/// 安全な整数の割り算
fn safe_divide(a: Int, b: Int) -> Result(Int, String) {
  case b {
    0 -> Error("ゼロ除算")
    _ -> Ok(a / b)
  }
}

/// 文字列を年齢としてパース
fn parse_age(input: String) -> Result(Int, String) {
  case int.parse(input) {
    Ok(n) if n > 0 -> Ok(n)
    Ok(_) -> Error("年齢は正の数でなければなりません")
    Error(_) -> Error("不正な数値: " <> input)
  }
}

/// use + result.try を使った計算の例
fn calculate(a_str: String, b_str: String) -> Result(String, String) {
  use a <- result.try(parse_int_safe(a_str))
  use b <- result.try(parse_int_safe(b_str))
  use quotient <- result.try(safe_divide(a, b))
  Ok(
    int.to_string(a)
    <> " / "
    <> int.to_string(b)
    <> " = "
    <> int.to_string(quotient),
  )
}

/// 文字列を Int にパース (Result を返す)
fn parse_int_safe(input: String) -> Result(Int, String) {
  int.parse(input)
  |> result.replace_error("パースエラー: " <> input)
}
