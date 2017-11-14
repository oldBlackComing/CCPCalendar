#!/bin/sh

#  ipa.sh
#  HunBaSha
#
#  Created by GarrettGao on 2017/1/3.
#  Copyright © 2017年 hunbohui. All rights reserved.

# 工程名
TARGET="MuYing"

# 编译类型 默认为Release
BUILD_TYPE="InHouse"

#bundleID
BuildETPBundle_ID="com.hunbohui.yingbashaETP"
BuildAppStoreBundle_ID="com.hunbohui.yingbasha"


if [ ! -z $1 ]
then
	buildType=$1
fi

if [ -z $buildType ] 
	then
		echo "\n请输入编译类型\n1.Release\n2.InHouse\n3.Hoc\n4.Debug\n"
		read -p "(直接输入数字): " buildType
fi

if [ "$buildType"x = "1"x ];then
    BUILD_TYPE="Release"

elif [ "$buildType"x = "2"x ];then
    BUILD_TYPE="InHouse"

elif [ "$buildType"x = "3"x ];then
    BUILD_TYPE="Hoc"

elif [ "$buildType"x = "4"x ];then
    BUILD_TYPE="Debug"

else
    echo "输出错误 end"
    exit 0;
fi



# 获取当前目录
XCODEPROJECT_PATH=$(pwd)

# 进入目录
cd "${XCODEPROJECT_PATH}"

BuildBundle_ID=${BuildETPBundle_ID}
if [ ${BUILD_TYPE} != "InHouse" ]; then
	  BuildBundle_ID=${BuildAppStoreBundle_ID}
  fi

# 时间
CURTIME=`date +%m_%d__%H_%M_%S`

# app文件路径
APP_PATH="${XCODEPROJECT_PATH}/build/${BUILD_TYPE}-iphoneos/${TARGET}.app"

# ipa输出地址，如果没有自动创建
if [ ${BUILD_TYPE} == "InHouse" ]; then
CURTIME="${CURTIME}-ETP"
fi

IPA_FIEL_PATH="${XCODEPROJECT_PATH}/ipa/${CURTIME}"
IPA_PATH="${XCODEPROJECT_PATH}/ipa"

if [ ! -d "${IPA_PATH}" ]; then
mkdir -p "${IPA_PATH}"
fi

  
echo ${BuildBundle_ID}
# 使用xcodebuild工具开始打包
# xcodebuild -target "${TARGET}" -configuration "${BUILD_TYPE}" build
#xcodebuild archive -scheme MuYing -configuration InHouse -workspace MuYing.xcworkspace -archivePath ./ipa/ PRODUCT_BUNDLE_IDENTIFIER=com.hunbohui.yingbashaETP #使用pod
#xcodebuild -exportArchive -archivePath "${IPA_FIEL_PATH}.xcarchive" -exportOptionsPlist ./ETP.plist -exportPath ${IPA_FIEL_PATH}

xcodebuild archive -scheme "${TARGET}" -configuration "${BUILD_TYPE}" -workspace ${TARGET}.xcworkspace -archivePath ${IPA_FIEL_PATH} PRODUCT_BUNDLE_IDENTIFIER="${BuildBundle_ID}" #使用pod

############## 编译 完成后，选择是否输出 ipa 文件
echo "\n\n是否生成ipa文件？\n"

read -p "（输入 y 或 n）" is
if [ "$is" != "y" ] && [ "$is"  != "Y" ];then
    echo "END !"
    exit 0;
fi



#编译完成后，使用xcrun命令 输出.ipa文件
xcodebuild -exportArchive -archivePath "${IPA_FIEL_PATH}.xcarchive" -exportOptionsPlist ./ETP.plist -exportPath ${IPA_PATH}


#打开
open "${IPA_FIEL_PATH}"


#####
# 是否发布到 fir 测试平台(考虑有的同学没有安装 fir，暂时屏蔽)
#read -p "\n\n是否发布到fir平台\n（输入 y 或 n）" isPublish
#if [ "$isPublish" = "y" ] || [ "$isPublish"  = "Y" ];then
#    fir publish "${IPA_PATH}"
#    echo ${IPA_PATH}
#else
#    echo "END !"
#fi

#END
