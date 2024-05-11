#!/bin/bash
# 启动/停止aria2脚本

# BT tracker 下载地址
DOWNLOAD_BT_TRACKER=https://trackerslist.com/all_aria2.txt

# 操作参数
op=

# 结构化打印
ECHO_FORMAT_INFO() {
	echo -e "\033[34m==> $1\033[0m"
}
ECHO_FORMAT_ERROR() {
	echo -e "\033[31m==> $1\033[0m"
}

# 执行启动脚本
EXEC_FUNC() {
	if [[ $op == 1 || $op == "start" ]]; then
		#statements
		PID=$(ps -ef | grep "aria2c" | grep -v "cgroup" | grep -v "grep" | awk '{print $2}')
		if [[ $? -eq 0 && -n $PID ]]; then
			ECHO_FORMAT_ERROR "aria2已启动"
		else
			ECHO_FORMAT_INFO "更新 bt-tracker 服务器信息....."
			list=$(curl -fsSL ${DOWNLOAD_BT_TRACKER})
		    sed -i '' "s@bt-tracker.*@bt-tracker=${list}@g" "${HOME}/.aria2_/aria2.conf"

			ECHO_FORMAT_INFO "启动aria2..."
			mv $HOME/.aria2_ $HOME/.aria2
			aria2c --conf-path=$HOME/.aria2/aria2.conf -D
		fi

	elif [[ $op == 0 || $op == "stop" ]]; then # 
		#statements
		PID=$(ps -ef | grep "aria2c" | grep -v "cgroup" | grep -v "grep" | awk '{print $2}')
		if [[ $? -eq 0 && -n $PID ]]; then
			ECHO_FORMAT_INFO "停止aria2..."
			kill -9 ${PID}
			mv $HOME/.aria2 $HOME/.aria2_
		else
			ECHO_FORMAT_ERROR "aria2已停止"
		fi
	else
		ECHO_FORMAT_ERROR "参数错误:$1【启动: start or 1 停止: stop or 0】"
	fi
}

# 获取执行参数
READ_FUNC() {
	if [[ ! -n $1 ]]; then
		#statements
		ECHO_FORMAT_INFO "【选择操作:】\n > 启动: start or 1\n > 停止: stop or 0"
		read op
	else
		op=$1
	fi
}

READ_FUNC $1
EXEC_FUNC

exit