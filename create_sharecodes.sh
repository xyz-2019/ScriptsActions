#!/bin/sh

export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export LC_ALL=C

ShellDir=$(cd $(dirname $0); pwd)
RootDir=$(cd $(dirname $0); cd ..; pwd)
ScriptsDir=${RootDir}/scripts
LogDir=${RootDir}/log
LogFile=${LogDir}/create_share_codes/create_share_codes.log
CreateURLJDZZ="https://code.chiang.fun/api/v1/jd/jdzz/create/"
CreateURLDdfactory="http://api.turinglabs.net/api/v1/jd/ddfactory/create/"
CreateURLJxfactory="http://api.turinglabs.net/api/v1/jd/jxfactory/create/"
CreateURLBean="http://api.turinglabs.net/api/v1/jd/bean/create/"
CreateURLFarm="http://api.turinglabs.net/api/v1/jd/farm/create/"
CreateURLPet="http://api.turinglabs.net/api/v1/jd/pet/create/"
URLServerChan="https://sc.ftqq.com/"

## 删除旧的日志，创建新的日志
if [ ! -d ${LogDir}/create_share_codes ]; then
  mkdir -p ${LogDir}/create_share_codes
fi
cd ${LogDir}/create_share_codes/
rm -f ${LogFile}
touch ${LogFile}

## 提交京东赚赚互助码
CreateCodesJDZZ() {
  echo  "京东赚赚：\n\n" >> ${LogFile}
  for Code in ${ShareCodesJDZZ}
  do
    sleep 10
    wget -q -O ${Code} ${CreateURLJDZZ}${Code}
    echo -n "${Code}: " >> ${LogFile}
    cat ${Code} >> ${LogFile}
    echo  "\n\n" >> ${LogFile}
    rm -f ${Code}
  done
  echo  "\n\n" >> ${LogFile}
}

## 提交东东工厂互助码
CreateCodesDdfactory() {
  echo  "东东工厂：\n\n" >> ${LogFile}
  for Code in ${ShareCodesDdfactory}
  do
    sleep 10
    wget -q -O ${Code} ${CreateURLDdfactory}${Code}
    echo -n "${Code}: " >> ${LogFile}
    cat ${Code} >> ${LogFile}
    echo  "\n\n" >> ${LogFile}
    rm -f ${Code}
  done
  echo  "\n\n" >> ${LogFile}
}

## 提交京喜工厂互助码
CreateCodesJxfactory() {
  echo  "京喜工厂：\n\n" >> ${LogFile}
  for Code in ${ShareCodesJxfactory}
  do
    sleep 10
    wget -q -O ${Code} ${CreateURLJxfactory}${Code}
    echo -n "${Code}: " >> ${LogFile}
    cat ${Code} >> ${LogFile}
    echo  "\n\n" >> ${LogFile}
    rm -f ${Code}
  done
  echo  "\n\n" >> ${LogFile}
}

## 提交种豆得豆互助码
CreateCodesBean() {
  echo  "种豆得豆：\n\n" >> ${LogFile}
  for Code in ${ShareCodesBean}
  do
    sleep 10
    wget -q -O ${Code} ${CreateURLBean}${Code}
    echo -n "${Code}: " >> ${LogFile}
    cat ${Code} >> ${LogFile}
    echo  "\n\n" >> ${LogFile}
    rm -f ${Code}
  done
  echo  "\n\n" >> ${LogFile}
}


## 提交东东农场互助码
CreateCodesFarm() {
  echo  "东东农场：\n\n" >> ${LogFile}
  for Code in ${ShareCodesFarm}
  do
    sleep 10
    wget -q -O ${Code} ${CreateURLFarm}${Code}
    echo -n "${Code}: " >> ${LogFile}
    cat ${Code} >> ${LogFile}
    echo  "\n\n" >> ${LogFile}
    rm -f ${Code}
  done
  echo  "\n\n" >> ${LogFile}
}

## 提交东东萌宠互助码
CreateCodesPet() {
  echo  "东东萌宠：\n\n" >> ${LogFile}
  for Code in ${ShareCodesPet}
  do
    sleep 10
    wget -q -O ${Code} ${CreateURLPet}${Code}
    echo -n "${Code}: " >> ${LogFile}
    cat ${Code} >> ${LogFile}
    echo  "\n\n" >> ${LogFile}
    rm -f ${Code}
  done
  echo  "\n\n" >> ${LogFile}
}

## 向服务器提交互助码

if [ -n "${ShareCodesJDZZ}" ]; then
  CreateCodesJDZZ
fi

if [ -n "${ShareCodesDdfactory}" ]; then
  CreateCodesDdfactory
fi

if [ -n "${ShareCodesJxfactory}" ]; then
  CreateCodesJxfactory
fi

if [ -n "${ShareCodesBean}" ]; then
  CreateCodesBean
fi

if [ -n "${ShareCodesFarm}" ]; then
  CreateCodesFarm
fi

if [ -n "${ShareCodesPet}" ]; then
  CreateCodesPet
fi

## 向方糖发送消息
if [ -n "${SCKEY}" ]; then
  desp=$(cat ${LogFile})
  wget -q --output-document=/dev/null --post-data="text=互助码提交状态&desp=${desp}" ${URLServerChan}${SCKEY}.send
fi
