#!/usr/bin/bash

# 入力数が正しいか確認
if [ "$#" -ne 2 ]; then
	echo "引数エラー: ２つの自然数を入力してください。" >&2
	exit 1
fi

# 入力が自然数か確認
if ! [[ $1 =~ ^[0-9]+$ ]] || ! [[ $2 =~ ^[0-9]+$ ]] || [[ "$1" -eq 0 ]] || [[ "$2" -eq 0 ]]; then
	echo "引数エラー: 自然数を入力してください。" >&2
	exit 1
fi

# メインの処理
function calculate_gcd() {
	local a=$1
	local b=$2
	while [ "$b" -ne 0 ]; do
		local remainder=$(( a % b ))
		a=$b
		b=$remainder
	done
	echo "$a"
}

result=$(calculate_gcd "$1" "$2")
echo "最大公約数: $result"
