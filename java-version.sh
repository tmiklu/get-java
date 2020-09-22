#!/bin/bash

if [ $# -eq 1 ]
  then
    exit 0
else
    echo -e "usage: ./java-version.sh <namespace>"
    exit 1
fi

export STATUS=Running

while read line 
do
 EXITSTATUS=$?
 if [ ${EXITSTATUS} -gt 0 ]
 sleep 1
  then
   echo -e "\033[1;32mcontainer:\033[m \033[4;31""m${line}\033[0m"
   oc exec -t ${line} --namespace=${1} -- java -version | - 2> /dev/null
 fi
done < <(oc get pods | grep -v NAME | awk -v LIMIT=${STATUS} '($3>=LIMIT) { print $1 }')
