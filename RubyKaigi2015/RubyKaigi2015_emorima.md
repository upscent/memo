- emorima
  - Rails Girls Tokyo 3rd and 4th
  - Asakusa.rb 飲み会担当
    - Asakusa.rb meetup after RubyKaigi 2015
- Thread
  - メモリの共有など
- 1.8.6 vs 2.2.3
  - 1.8.6では止まったけど2.2.3でどうなるか…？
    - for文のループを同時に？
      - 2.2.3のほうがCPUの使用率高い…！
      - CPUの負荷は高い…ということは実行回数が多いのでは！？と思ったら同じだった＼(^o^)／
    - 1万スレッドで例外が出たら死んだ
      - メモリ使用量は下がっている！
        - 例外クラスのインスタンスを生成するというのがすごく重い処理
- Erlangは？
  - Crytical mission なので新しい言語を取り入れるのは厳しいかも…