自己紹介
- dump load 使ったよ
- VM・GCの高速化
- heroku の ruby フルコミッター

Compling Ruby Script
- コンパイルもいろいろ
  - JIT Just in time
  - AOT ahead of time
    - [今日のテーマ] Program to presistent byte code
- メモリ消費量
  - 抑えたい
  - マルチプロセス間でもbyte codeを共有できるように
- ロード方法の工夫
  - 遅延ロード
- 下記は決めない！！！
  - コンパイルのタイミングは？
    - ユーザが明示的に？
    - ロードのタイミングで？
  - コンパイル先は？
- [sample/iseq_loader.rb](https://github.com/ruby/ruby/blob/v2_3_0_preview2/sample/iseq_loader.rb)
- 評価
  - 1,000回読み込んだ速度
    - 最大5倍早くなった！
    - でも1,000回もロードしないよ
  - byte codeが大きいので縮めたい
