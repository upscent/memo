- GMOペパボなう
  - minne: フルスタックRailsのサービス
  - やおくらうど？
    - open stack なのにさくらサーバ用のgemが
  - mruby でコマンドラインとか作ってる
- system ではなく global で
- OSS貢献
  - 「OSS貢献簡単やで！ドキュメント書いてパッチ書けばええんやで！」はちょっと…
    - 実際正しく動くかわからない
    - ドキュメント書くの楽しくない。英語つらい。
  - テストする！実行する！なら簡単
    - 書いてないテストは？
    - 実行環境によってはエラー？
- make test
  - test-sample
    - test-sampleを実行するとsample以下のテストが何故か動く！ matzさんがいれた？
    - 代入処理などの基本的な演算のテスト
  - btest-ruby
  - test-knownbug
    - KNAOWNBUGS.rb
    - 明らかなバグを記載する
- make-test-all
  - `test/ruby` 組み込みのテスト
  - `test/xxx` 標準添付のライブラリのテスト
  - 環境変数 `TESTS`
    - `TESTS=logger` loggerのテストだけ実行される
    - `TESTS="-j4"` 4並列で実行できる
  - `test/-ext-/array/test_resize.rb`
- test-testframework
  - テストをテストするためのテスト…？
- 直接minitestをつかっているもの
  - rubygems, rdoc
  - rubygemsは1.8をサポートしている
- test/lib/envutil.rb はやばい
- RubySpec
  - specificationではない…？
  - 仕様は皆さんの心にある！
- rubyspecとmspec
- rubyci
  - マイナーな環境での実行結果は有用！
