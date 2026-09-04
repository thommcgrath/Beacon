#!/bin/bash
\. "$HOME/.nvm/nvm.sh"

case $1 in
	-w | --watch)
		node_modules/.bin/webpack --watch &
		webpack_pid=$!
		node_modules/.bin/sass --watch --style compressed --no-source-map src/scss:www/assets/css &
		sass_pid=$!
		wait $webpack_pid $sass_pid;
		;;
	*)
		node_modules/.bin/webpack
		node_modules/.bin/sass --style compressed --no-source-map src/scss:www/assets/css
		;;
esac
