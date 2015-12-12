演者紹介
- solaris向けのrubyメンテナー

- solaris
  - SPARC solaris
  - Intel solaris
- 最近はlinuxだが再現性などを担保するために古いソフトを使う必要がある
- solarisは歴史的経緯から同じコマンドが異なるパスに複数存在する
  - rubyのコンパイルはGNUがべたー
  - cssでもできなくはないが…
- LD_LIBRARY_PATHはglobalで設定しない
- 64bitコンパイルオプションをつけても名前は32ビット
  - `--build` オプションで名前を付け替えてあげると良い
