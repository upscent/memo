ruby2.3
- did you mean
- Enumerable#grep_v
- Hash
  - #fetch_values
  - #to_proc
- Numeric#positive?, Numeric#negative?
- Hash Comparisons
  - `> >= < <=`
  - `<=>` はないよ
- Array Hash … #dig ネストした配列にアクセスできる
- インデント
- frozen string literal
- safe navigation operator
  - 他言語でいう `?.`
  - `&.hoge`
  - ぼっちオペレーター！
- ちょい早
  - 年5%はやくなっております！
  - 貢献者: Koichi, Nobu, Eric Wong
  - コミュニティの成果！ありがとう！！

mruby
- 大きな変化はないけどがんばってるお

Streem
- https://github.com/matz/streem

- まぁバックアップ用てきとーにと思っていたら…
  - ??「Matzが新しい言語を！！！」　Matzさん「！？」
  - ??「つ PR ここパッチ当てたらええよ」　Matzさん「！？」
  - ??「インタプリタ書いたお！」　Matzさん「！？」

OSScaas
- OSSは進み続けていないと死ぬ
- 変化は好き。しかし変化は苦痛にもなる。
  - アプリのレビュー見るとインタフェースへの文句はあったりなかったり…
- y-combinator
- 欲しいものではなく必要なものを作れ
  - Ruby もリリース当時はOOなんていらん！と言われていたがそんなことはなかった
  - 「将来欲しいもの」を作った
- 2000 Ruby 問題に直面
  - パフォーマンス
  - 英語・日本語以外の言語への対応 1.9.9
- 1.9.9 互換性の問題で普及するのは5年
  - Python3 よりマシかな…w
  - エラーが出たときの対処法を提示する
  - 「関数型言語にしたい」「imutableにしたい」なんて思ったときもあったけど
  - 変化は一歩一歩確実に
  - できたところからちまちまリリース
- Ruby開発時のルール
  - 全部捨てるな！
  - せかすな
  - 互換性を壊すときなら理由を提示する
  - 利益を提供する
- Ruby3
  - 環境は変わる
    - コア数が増える
    - コード・データのスケーラビリティ
  - Actor model
    - Erlang
  - ownership model
    - アクターを渡す際にownershipを渡す
  - stearm model
  - OK GO programing?
  - Dialyzer(Erlang)
  - 早い！と文句が出ることはない
    - Ruby3 × 3  Ruby2より3倍早くする
      - Concurrency
      - 最初にコンパイル
      - ただし
        - Ruby2.0
        - ベンチマークは俺に任せろ！
        - Ruby2.3よりメモリ消費量を抑えたい
  - 2020 東京オリンピック前には…！！！
  - herok, appfolio, Money Forward, IBM J9
