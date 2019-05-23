#!/bin/bash
# -------------------------------------------------------------------------------
# Author:   Loya.Chen
# Description: Execute commands on multiple remote hosts at the same time.
# -------------------------------------------------------------------------------
set -e
Usage() {
  echo "Usage: $0 host1 host2 ... 'command'"
}
if [ $# -lt 2 ] ;then
  Usage
  exit 0
else
  cmd=${!#}
fi
logfile=$(mktemp)
i=1
success=0
failed=0

  if [ $i -eq $# ];then
    break
  fi
  ssh $ip $cmd &> $logfile
  if [ $? -eq 0 ];then
    #((success++))
    success=$(($success+1))
    echo -e "\n\033[32m$ip | success \033[0m \n"
    cat $logfile
  else
    ((failed++))
    echo -e "\n\033[31m$ip | failed \033[0m\n "
    cat $logfile
  fi
  ((i++))
done
echo -e '\n-------------------------'
echo -e "\033[32msuccess: $success | failed: $failed \033[0m"
echo '-------------------------'