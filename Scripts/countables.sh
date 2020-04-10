#!/bin/bash
#version:0.1
#author:Jun.Wang
##修改impalad 主机名或者IP
##传入数据库名称
##统计数据库中，dbo_*表的数据量

if [ $# -eq 1 ];then
  IMPALAD_HOST=app34
  DB_NAME=$1
  aa=`impala-shell -i $IMPALAD_HOST -d $DB_NAME --quiet -q "show tables"`
  if [ $? -eq 0 ];then 
    echo -e "表名称\t\t   表数据量"
    for i in $aa
    do
      for j in $(echo "$i" |grep "dbo_")
        do
          #echo $j
          bb=`impala-shell -i $IMPALAD_HOST -d $DB_NAME --quiet -q "select count(*) AS T from $DB_NAME.$j"`
          echo $bb |awk '{print "'"$j"'",$7}'
        done
    done
  else
    echo "你输入的数据库:$DB_NAME 不存在！"
  fi

else
  echo "提示：请输入数据库名。"
  exit 1
fi
