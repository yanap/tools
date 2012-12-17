tools
=====

I try to make various tools.

■ sublimetext2のパッケージをDropboxと同期するスクリプト

~/ に自分がいる前提です。 ※Macしか無理です。

- 導入方法

※　注意

実行する前にSublime Text 2 はアプリケーションが終了している状態なのを確認して

起動した状態で実行するとエラーでまくります。

まず、ターミナルを開きます。

1. ホームディレクトリにいきます。

cd

2. githubからソースをダウンロードします。

git clone git@github.com:yanap/tools.git

↑のままだと、toolsディレクトリが生成されるので変えたい場合は

git clone git@github.com:yanap/tools.git sublimetext2syncscript

とか、適当に名前を変えてください。

3. インストールしてください

./sublime-packages-sync-to-dropbox.sh

4. 完了です

確認したい場合は

cd /Users/yanai_masahiro/Library/Application Support/Sublime Text 2

ls -l

で

$ls -l

Backup/

Installed Packages@ -> /Users/yanai_masahiro/Dropbox/Sublime Text 2/Installed Packages

Installed Packages_Original/

Packages@ -> /Users/yanai_masahiro/Dropbox/Sublime Text 2/Packages

Packages_Original/

Pristine Packages@ -> /Users/yanai_masahiro/Dropbox/Sublime Text 2/Pristine Packages

Pristine Packages_Original/

Settings/

こうなってるか確認してください。

■ヘルプ

./sublime-packages-sync-to-dropbox.sh help

■リセット

Dropboxと同期するのをやっぱりやめてもとに戻す

./sublime-packages-sync-to-dropbox.sh reset

Dropboxでパッケージを同期できるようになったはずなので

Sublime Text 2 を起動しよう!

