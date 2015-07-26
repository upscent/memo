# railsでhogehogeを作ろう！

# 開発環境の構築

参考：[開発現場でちゃんと使えるRails 4入門（1）：簡単インストールから始める初心者のためのRuby on Railsチュートリアル](http://www.atmarkit.co.jp/ait/articles/1402/28/news047.html)

- rvmの導入 http://rvm.io/
  - xcode command line tools 入れてないと怒られる
- `bundle exec rails generate scaffold user name:string encrypted_password:string`
- `bundle exec rails g migration rename_encrypted_password_column_to_users password_digest`
- [bcrypt-rubyをRailsで使う](http://bakunyo.hatenablog.com/entry/2013/05/26/bcrypt-ruby%E3%82%92Rails%E3%81%A7%E4%BD%BF%E3%81%86)
- `attr_accessible`
  - http://willnet.in/48
  - http://qiita.com/aquamikan/items/57c6c95b39f961a18453
- [Railsのmigrationの基本とレシピ集](http://ruby-rails.hatenadiary.com/entry/20140810/1407634200)
- セッション管理
  - [Railsのセッション管理方法について](http://shindolog.hatenablog.com/entry/2014/11/02/164118)
  - [memcachedを利用したsession管理](http://qiita.com/ThreeTreesLight/items/bb1a5960a54fd214c674)
  - [macにmemcachedをインストールする方法と動作確認](http://joppot.info/2014/07/09/1684)
  - 「Devise」を使えば簡単…？ 参考：[Railsのログイン認証gemのDeviseのカスタマイズ方法](http://shindolog.hatenablog.com/entry/2014/11/02/164118)
- unicorn, nginx, railsの設定
  - [nginx + unicorn + Railsの設定方法](http://qiita.com/akito1986/items/56198edcafc222b320a8)
- [RailsのデータベースをSQLiteからMySQLに変更する](http://d.hatena.ne.jp/minamijoyo/20150205/p2)
