#!/bin/bash

NAMESPACE=$1

if [ $# -eq 1 ]
  then
    echo -e "Checking project \033[1;34""m${NAMESPACE}...\033[0m"
else
    echo -e "usage: ./java-version.sh <namespace>"
    exit 1
fi

export STATUS=Running

while read line 
do
 EXITSTATUS=$?
 if [ $EXITSTATUS -gt 0 ]
 sleep 1
  then
   echo -e "\033[1;32mcontainer:\033[m \033[4;31""m${line}\033[0m"
   oc exec -t ${line} --namespace=${NAMESPACE} -- java -version | - 2> /dev/null
 fi
done < <(oc get pods --namespace=${NAMESPACE} | grep -v NAME | awk -v LIMIT=${STATUS} '($3>=LIMIT) { print $1 }')
