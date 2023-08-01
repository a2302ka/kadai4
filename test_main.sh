#!/usr/bin/bash

# 入力数が少ない場合
# 入力なし
# 入力１個
# 入力３個以上

# 正の自然数以外が入力された場合
# a b -> "error: plz input natural number"
# -1

# 最大公約数が計算できているか
# 2 4 -> 2
echo "2" > /tmp/$$-ans
./main.sh 2 4 > /tmp/$$-result
diff /tmp/$$-ans /tmp/$$-result || echo "テスト3-1" >> /tmp/$$-error.log 


# 1000 100 ->100
# 12 8 -> 4

if [ -f /tmp/$$-error.log ];then
	cat /tmp/$$-error.log 1>&2
	rm -f /tmp/$$-*
	exit 1
fi
