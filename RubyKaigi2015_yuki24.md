自己紹介
- kaminari gem
- did_you_meadn gem

did you mean
- git も Google もリコメンドしてくれる！Rubyでもやりたい！
- やってること
  - スペルチェック
    - 正しい単語のリスト
      - `Symbol.all_symbols` 2万超
    - リストから近いものを選択する
      - ミスタイプ：単語は知っているけどキーボードミスした
        - Levenshtein距離
      - ミススペル：単語覚えてない(でも先頭の文字はあっている)
        - Jaro-Winkler距離 = Jaro距離 + prefix bonus
          - Jaro距離
        - ミススペルチェックはミスタイプ候補がない場合のみ
        - Jaro-Winkler距離だけだと見当違いな候補を出すので、Levenshtein距離で絞り込む
    - 最適化
      - コンテキストによって辞書を使い分ける
  - モンキーパッチ
    - NameError#name, NoMethodError#name でユーザの入力を取り出せる
    - NoMethodError#receiver 呼び出されたオブジェクト
