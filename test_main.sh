#!/usr/bin/bash

# エラー発生時の処理
function err_catch {
	echo "エラー: test_main.shを実行中にエラーが発生しました。"
	exit 1
}
trap err_catch ERR

# 終了時に必ず実行する処理
function final_func {
	rm -f /tmp/$$-*
	echo "動作確認が終了しました。"
}
trap final_func EXIT

# ファイル名を変数に代入
ans=/tmp/$$-ans
result=/tmp/$$-result
err_log=/tmp/$$-errors

# ./main.shがエラー終了した際にERRトラップがキャッチしないように無効化する
trap ERR

# 入力数が２でない場合
# 入力なし
echo "引数エラー: ２つの自然数を入力してください。" > ${ans}
./main.sh 2> ${result}
diff ${ans} ${result} || echo "テスト1-1: 入力数が正しく判定されませんでした。" >> ${err_log}

# 入力１個
echo "引数エラー: ２つの自然数を入力してください。" > ${ans}
./main.sh 3 2> ${result}
diff ${ans} ${result} || echo "テスト1-2: 入力数が正しく判定されませんでした。" >> ${err_log}

# 入力３個以上
echo "引数エラー: ２つの自然数を入力してください。" > ${ans}
./main.sh 1 2 3 2> ${result}
diff ${ans} ${result} || echo "テスト1-3: 入力数が正しく判定されませんでした。" >> ${err_log}


# 自然数以外が入力された場合
# 負数 -1 3
echo "引数エラー: 自然数を入力してください。" > ${ans}
./main.sh -1 3 2> ${result}
diff ${ans} ${result} || echo "テスト2-1: 引数が正しく判定されませんでした。" >> ${err_log}

# 負数 -2 -4
echo "引数エラー: 自然数を入力してください。" > ${ans}
./main.sh -2 -4 2> ${result}
diff ${ans} ${result} || echo "テスト2-2: 引数が正しく判定されませんでした。" >> ${err_log}

# 小数 1.5 1
echo "引数エラー: 自然数を入力してください。" > ${ans}
./main.sh 1.5 1 2> ${result}
diff ${ans} ${result} || echo "テスト2-3: 引数が正しく判定されませんでした。" >> ${err_log}

# 小数 1.5 0.5
echo "引数エラー: 自然数を入力してください。" > ${ans}
./main.sh 1.5 0.5 2> ${result}
diff ${ans} ${result} || echo "テスト2-4: 引数が正しく判定されませんでした。" >> ${err_log}

# 文字 "hello" "world"
echo "引数エラー: 自然数を入力してください。" > ${ans}
./main.sh "hello" "world" 2> ${result}
diff ${ans} ${result} || echo "テスト2-5: 引数が正しく判定されませんでした。" >> ${err_log}

# 文字 "やあ" "こんにちは"
echo "引数エラー: 自然数を入力してください。" > ${ans}
./main.sh "やあ" "こんにちは" 2> ${result}
diff ${ans} ${result} || echo "テスト2-6: 引数が正しく判定されませんでした。" >> ${err_log}


# 最大公約数が正しく計算できているか
# 2 4 -> 2
echo "最大公約数: 2" > ${ans}
./main.sh 2 4 > ${result}
diff ${ans} ${result} || echo "テスト3-1: 計算結果に誤りがあります。" >> ${err_log}

# 1000 100 -> 100
echo "最大公約数: 100" > ${ans}
./main.sh 1000 100 > ${result}
diff ${ans} ${result} || echo "テスト3-2: 計算結果に誤りがあります。" >> ${err_log}

# 12 8 -> 4
echo "最大公約数: 4" > ${ans}
./main.sh 12 8 > ${result}
diff ${ans} ${result} || echo "テスト3-3: 計算結果に誤りがあります。" >> ${err_log}

# ERRトラップを再度有効化する
trap err_catch ERR

if [ -f /tmp/$$-errors ];then
	cat /tmp/$$-errors 1>&2
	exit 1
fi
