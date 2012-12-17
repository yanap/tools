#!/bin/sh

already_installed()
{
	result=0
	if [ -L ~/Library/Application\ Support/Sublime\ Text\ 2/Installed\ Packages ]
	then
		reuslt=1
	fi

	if [ -L ~/Library/Application\ Support/Sublime\ Text\ 2/Packages ]
	then
		reuslt=1
	fi

	if [ -L ~/Library/Application\ Support/Sublime\ Text\ 2/Pristine\ Packages ]
	then
		reuslt=1
	fi

	if [ ${result} -eq 1 ]
	then
		echo 'already_installed'
		exit
	fi
}

has_dropbox()
{
	if [ ! -d ~/Dropbox ]
	then
		echo 'Dropboxを起動してください'
		exit
	fi
}

has_subl()
{
	if [ ! -d ~/Library/Application\ Support/Sublime\ Text\ 2 ]
	then
		echo 'sublime text2をインストールしてください'
		exit
	fi
}

command_fail()
{
	if [ $? -ne 0 ]
	then
		echo ${1}' is failed';
		exit
	fi
}

reset_setting()
{
	echo 'Dropboxとの同期をやめて元に戻しますか？ [y/n]'
	read ANS

	if [ $ANS = 'y' -o $ANS = 'yes' ]
	then

has_subl

		cd  ~/Library/Application\ Support/Sublime\ Text\ 2/

		rm -rf Installed\ Packages Packages Pristine\ Packages

		mv ./Installed\ Packages_Original ./Installed\ Packages

		mv ./Packages_Original ./Packages

		mv ./Pristine\ Packages_Original ./Pristine\ Packages

		echo 'Dropboxと同期される前の状態にもどりました'
	fi
}

init()
{
	case $1 in
		'help')
			echo 'usage: sublime-package-sync-dropbox [reset|help]'
			echo 'resetはDropboxと同期する前に戻します'
			exit
		;;
		'reset')
			reset_setting
			exit
		;;
	esac
}

make_dir_on_dropbox()
{
	if [ ! -d ~/Dropbox/Sublime\ Text\ 2/Installed\ Packages ]
	then
		mkdir -p ~/Dropbox/Sublime\ Text\ 2/Installed\ Packages
	fi

	if [ ! -d ~/Dropbox/Sublime\ Text\ 2/Packages ]
	then
		mkdir -p ~/Dropbox/Sublime\ Text\ 2/Packages
	fi

	if [ ! -d ~/Dropbox/Sublime\ Text\ 2/Pristine\ Packages ]
	then
		mkdir -p ~/Dropbox/Sublime\ Text\ 2/Pristine\ Packages
	fi
}

init ${1}

already_installed

has_dropbox

has_subl

cd  ~/Library/Application\ Support/Sublime\ Text\ 2/
pwd

make_dir_on_dropbox

if [ -d ./Installed\ Packages ]
then
	rsync -avn ./Installed\ Packages ~/Dropbox/Sublime\ Text\ 2/
	command_fail 'rsync'
	if [ ! -L ./Installed\ Packages  ]
	then
		rsync -a ./Installed\ Packages ~/Dropbox/Sublime\ Text\ 2/
		mv ./Installed\ Packages ./Installed\ Packages_Original
	fi
fi

if [ -d ./Packages ]
then

	rsync -avnu ./Packages ~/Dropbox/Sublime\ Text\ 2/
	command_fail 'rsync'
	if [ ! -L ./Packages ]
	then
		rsync -a ./Packages ~/Dropbox/Sublime\ Text\ 2/
		mv ./Packages ./Packages_Original
	fi
fi

if [ -d ./Pristine\ Packages ]
then
	rsync -avnu ./Pristine\ Packages ~/Dropbox/Sublime\ Text\ 2/
	command_fail 'rsync'
	if [ ! -L ./Pristine\ Packages ]
	then
		rsync -a ./Pristine\ Packages ~/Dropbox/Sublime\ Text\ 2/
		mv ./Pristine\ Packages ./Pristine\ Packages_Original
	fi
fi

rm -rf Installed\ Packages Packages Pristine\ Packages
command_fail 'Installed\ Packages Packages Pristine\ Packages の 3つのディレクトリを削除できませんでした。'

ln -s ~/Dropbox/Sublime\ Text\ 2/Installed\ Packages ./Installed\ Packages
command_fail '~/Dropbox/Sublime\ Text\ 2/Installed\ Packages にリンクを貼るのを失敗しました'

ln -s ~/Dropbox/Sublime\ Text\ 2/Packages ./Packages
command_fail '~/Dropbox/Sublime\ Text\ 2/Packages にリンクを貼るのを失敗しました'

ln -s ~/Dropbox/Sublime\ Text\ 2/Pristine\ Packages ./Pristine\ Packages
command_fail '~/Dropbox/Sublime\ Text\ 2/Pristine\ Packages にリンクを貼るのを失敗しました'

echo 'あなたのsublime text 2 のパッケージはDropboxで同期するように設定されました。'
exit
