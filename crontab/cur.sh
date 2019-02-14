#!/usr/bin/bash
# 此脚本帮助提交脚本任务，Usage: command.sh script.sh [arg1] [arg2] ...
# 注意单个参数不能有空格字符，否则会当做多个参数处理
# 
# 此脚本会设置必要的环境变量，
# 然后移动到提交脚本的所在目录，以此作为当前目录执行脚本。
#

if [ "$1" = "" ]; then
    echo 'Usage: command.sh script.sh [arg1] [arg2] ...' >&2
    exit 1
fi
. /etc/profile

cur_file=$(basename $1)

params=""
i=0
for param in "$@"; do
    if [ $i -gt 0 ]; then
        params=$params" "$param
    fi
    let i++
done    

cur_dir=$(dirname $1)
cd ${cur_dir}

script=`pwd`/${cur_file}
if [ ! "$params" = "" ]; then
    script=$script" "$params
fi

echo -e "<=== $script ===> `date '+%Y-%m-%d %H:%M:%S'`\n" | tr -s " " >&2
{ time $script; }
