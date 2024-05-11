#!/bin/sh
# 给aria2 RPC添加一个下载完成通知 for macOS
# 最终效果：当下载完成会在屏幕右上角弹出一个提示框显示具体下载完成的文件名，
# 同时中文语音播报：“有个文件下载完成，请查收！”
# 变量 3 表示下载完成文件的路径
# 具体提示框设置可参考`https://code-maven.com/display-notification-from-the-mac-command-line`。
# 不支持设置自定义图标

if [[ -e "$3.aria2" ]]; then
	rm "$3.aria2"
elif [[ -e "$3.torrent" ]]; then
	rm "$3.torrent"
fi

fname=`basename $3 | tr '\n' ' '`
osascript <<EOF
display notification "$fname" with title "【下载完成】"
EOF