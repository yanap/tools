tools
=====

I try to make various tools.

■ sublimetext2のパッケージをDropboxと同期するスクリプト

~/ に自分がいる前提です。 ※Macしか無理です。

- 導入方法

※　注意

実行する前にSublime Text 2 はアプリケーションが終了している状態なのを確認して

起動した状態で実行するとエラーでまくります。

git clone git@github.com:yanap/tools.git

./sublime-packages-sync-to-dropbox.sh

■ヘルプ

./sublime-packages-sync-to-dropbox.sh help

■リセット

Dropboxと同期するのをやっぱりやめてもとに戻す

./sublime-packages-sync-to-dropbox.sh reset

Dropboxでパッケージを同期できるようになったはずなので

Sublime Text 2 を起動しよう!

