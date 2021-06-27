#!/bin/bash

DateDelLog=$(date "+%Y-%m-%d" -d "${RM_LOG_DAYS_BEFORE} days ago")
for log in $(ls ${SCRIPTS_DIR}/log/*.log)
do
  LineDel=$(grep -n "${DateDelLog}" ${log} | tail -1 | awk -F ':' '{print $1}')
  sed -i "1,${LineDel}d" ${log}
done
