// ============================================================
// Gleam 基本文法ハンズオン – エントリーポイント
// ============================================================
// 実行したい章のコメントを外して gleam run してください。
// 全章を一度に実行することもできます。
// ============================================================

import gleam/io

import ch01_basics
import ch02_functions
import ch03_pattern_match
import ch04_custom_types
import ch05_lists
import ch06_pipes_and_use
import ch07_error_handling
import ch08_modules
import ch09_generics
import ch10_exercises

pub fn main() -> Nil {
  io.println("╔══════════════════════════════════════╗")
  io.println("║   Gleam 基本文法ハンズオン           ║")
  io.println("╚══════════════════════════════════════╝")
  io.println("")

  // 実行したい章のコメントを外してください
  ch01_basics.run()
  ch02_functions.run()
  ch03_pattern_match.run()
  ch04_custom_types.run()
  ch05_lists.run()
  ch06_pipes_and_use.run()
  ch07_error_handling.run()
  ch08_modules.run()
  ch09_generics.run()
  ch10_exercises.run()

  io.println("=== 全チャプター完了! ===")
}
