# Gleam 基本文法ハンズオン

Gleam v1.x (v1.15対応)。Erlang VM (BEAM) および JavaScript ランタイム上で動く、型安全で親しみやすい関数型言語 **Gleam** の基本文法を、実際にコードを書きながら学ぶためのハンズオン資料です。

---

## 目次

| 章 | テーマ | ファイル |
|----|--------|----------|
| 01 | Hello World & 基本の型 | `src/ch01_basics.gleam` |
| 02 | 関数 | `src/ch02_functions.gleam` |
| 03 | パターンマッチ | `src/ch03_pattern_match.gleam` |
| 04 | カスタム型 (type / enum) | `src/ch04_custom_types.gleam` |
| 05 | リスト & イテレーション | `src/ch05_lists.gleam` |
| 06 | パイプライン & use 式 | `src/ch06_pipes_and_use.gleam` |
| 07 | Result / Option によるエラー処理 | `src/ch07_error_handling.gleam` |
| 08 | モジュールとインポート | `src/ch08_modules.gleam` |
| 09 | ジェネリクス | `src/ch09_generics.gleam` |
| 10 | 総合演習 – FizzBuzz & 簡易スタック | `src/ch10_exercises.gleam` |
| 11 | Webサーバー (Mist) | `src/ch11_mist.gleam` |

---

## セットアップ

### Gleam 本体のインストール (mise を使用)

Gleam と実行環境となる Erlang/OTP を、マルチランタイムマネージャーの [mise](https://mise.jdx.dev/) を使ってインストールするのが推奨です。

#### 1. mise の導入

まだ `mise` がインストールされていない場合は、以下のコマンドでインストールできます。

```bash
# curl を使用したインストール
curl https://mise.run | sh

# macOS の場合は Homebrew でも可能です
# brew install mise
```

インストール後、シェルの設定ファイル（`.zshrc` や `.bashrc`）の末尾に `eval "$(mise activate zsh)"` などのアクティベート設定を追記し、設定を反映させてください。

```bash
# zsh の場合
echo 'eval "$(mise activate zsh)"' >> ~/.zshrc
source ~/.zshrc

# bash の場合
echo 'eval "$(mise activate bash)"' >> ~/.bashrc
source ~/.bashrc
```

これで `mise` コマンドが使用可能になります。

#### 2. Erlang と Gleam のインストール

```bash
# Erlang と Gleam の最新版をインストールしてグローバルで有効化
mise use --global erlang@latest gleam@latest

# インストールの確認
gleam --version
```

> [!TIP]
> プロジェクトごとにバージョンを固定したい場合は、プロジェクトルートで `mise use erlang@latest gleam@latest` （`--global` なし）を実行すると、`.mise.toml` が作成され管理が容易になります。

### プロジェクトのセットアップ
# 依存パッケージのダウンロード
cd /path/to/gleam/handson
gleam deps download

# 各章の実行方法 (handson.gleam の main を書き換えて実行)
gleam run

# テスト
gleam test
```

### Webアプリ開発（Mist）のセットアップ

Webサーバーを作成する場合は、以下のライブラリを追加します。

```bash
# 依存ライブラリの追加
gleam add mist gleam_http gleam_erlang
```

---

## 各章の進め方

1. 該当する `src/chXX_*.gleam` を開く
2. コード中の説明コメントを読む
3. `// TODO:` マークの箇所を自分で実装する
4. `src/handson.gleam` の `main` から対応する `run()` を呼び出し `gleam run` で実行して確認
5. 余裕があれば応用課題にも挑戦する

---

## 章の詳細解説

### Chapter 01 – Hello World & 基本の型

Gleam の型システムと基本構文の基礎を学びます。

- 基本的な型: `Int`, `Float`, `String`, `Bool`
- 変数バインディング (`let` 宣言)
- 不変性 (Gleam の変数は再代入不可)
- 標準出力 (`io.println`, `io.debug`)
- 複数行文字列や文字列結合

### Chapter 02 – 関数

- 名前の付いた関数 (`fn 関数名(...) -> 戻り値の型`)
- 引数と戻り値の型注釈 (Type Annotations)
- ラベル付き引数 (`label name: Type`) での呼び出し可読性向上
- 無名関数 (`fn(x) { x + 1 }`) と関数キャプチャ (`func(_, 10)`)
- 関数を引数に取る高階関数

### Chapter 03 – パターンマッチ

- `case` 式による条件分岐の基本
- リテラル・変数・ワイルドカード `_` によるマッチング
- 複数パターンの共用 (`|` 結合)
- ガード節 (`if` 句による追加条件)
- リスト (`[first, ..rest]`) やタプル・レコードのネストしたパターンマッチ
- 変数へのエイリアス割り当て (`as` キーワード)

### Chapter 04 – カスタム型 (型定義とEnum)

- `type` によるカスタム型 (レコード型) の定義
- 複数バリアントの定義 (Enum、代数的データ型的な使い方)
- レコードの更新構文 (`User(..user, age: 21)`)
- パターンマッチとの強力な連携による安全な状態管理
- `opaque type` を使った内部構造の隠蔽 (カプセル化)

### Chapter 05 – リスト & イテレーション (コレクションの操作)

- リスト型 (`List(Int)` など) の初期化 `[1, 2, 3]`
- `gleam/list` モジュールを活用したイテレーション
- `list.map`, `list.filter`, `list.fold`
- 先頭要素と残りの要素を分けるパターンマッチ `[first, ..rest]`

### Chapter 06 – パイプライン & use 式 (スッキリしたコードを書く)

- パイプ演算子 `|>` を使った連鎖的なデータ変換 (処理の左から右・上から下へのフロー)
- コールバック地獄を解消する `use` 式 (構文糖衣) の基礎
- カスタム関数の引数に `use` を適用するパターン

### Chapter 07 – Result / Option 型によるエラー処理 (Nullと例外の排除)

- `Result(value, error)` 型を使った成功・失敗の表現 (`Ok(v)`, `Error(e)`)
- `Option(value)` 型を使った “無いかもしれない” 値の表現 (`Some(x)`, `None`)
- `Result` から値を取り出す `result.unwrap`, `result.map`
- **超重要:** `use` 式と `result.try` を使った、例外の代わりに「早期リターン」を行うモダンな手法

### Chapter 08 – モジュールとインポート (コードの整理)

- 複数ファイル構成での関数・型の公開 (`pub` アクセス修飾子)
- `import module` での依存読み込み
- エイリアス (`as` / `import foo.{bar as my_bar}`) の活用
- 関数の修飾なしインポート (`import foo.{bar}`)

### Chapter 09 – ジェネリクス (汎用的な処理)

- 型引数をもつ関数 (`fn foo(x: a) -> a`)
- 型引数をもつカスタムレコード (`type Box(inner_type) { Box(value: inner_type) }`)
- コンパイラの型推論と型注釈による制約なしジェネリクスの強固さの確認

### Chapter 10 – 総合演習 (学んだことを形に)

- **FizzBuzz の実装:** `case` 条件分岐と `list` モジュールの反復適用
- **簡易スタック機能:** ジェネリック構造体と `push` / `pop` メソッド群の作成
- (Optional) `Result` 型で `pop` 時のエラーを返す安全設計の導入

### Chapter 11 – Webサーバー (Mist)

Gleam の代表的な HTTP サーバーである Mist を使った Web アプリケーションの構築を練習します。

- Mist の基本セットアップ (`gleam add mist`)
- `mist.run_service` による HTTP サーバーの起動
- `Request` オブジェクトからの情報取得（パス、クエリなど）
- `Response` オブジェクトの構築と返却
- `use` 式を組み合わせたミドルウェア的なハンドリングの基本

---

## 参考リンク

- [Gleam 公式サイト](https://gleam.run/)
- [Gleam Language Tour](https://tour.gleam.run/)
- [Gleam 標準ライブラリ ドキュメント](https://hexdocs.pm/gleam_stdlib/)
- [Gleam パッケージ検索 (Hex)](https://hex.pm/packages?search=gleam)
