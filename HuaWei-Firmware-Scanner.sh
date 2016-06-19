#!/bin/bash
# @Author:
# @Date:
# @Last Modified by:   anchen
# @Last Modified time:

echo "请输入手机型号: TL00 TL00H UL00"
read model

case $model in
    "TL00")
        ml="1021"
        ;;
    "TL00H")
        ml="1022"
        ;;
    "UL00")
        ml="1018"
        ;;
esac

Filter(){
    if [[ $1 == "1" ]]; then
        File="$PWD/$model/$i.xml"
        Size=`ls -il $File | awk '{print $6}'`
        if [ $Size == "162" ] || [ $Size == "0" ];then
            echo
            echo "This is Not to Download File, Will be Deleted!"
            echo "File:$File"
            echo "Size:$Size"
            rm $File
        fi
    else
        for f in `ls $PWD/$model`; do
            File=`ls -il $PWD/$model/$f | awk '{print $10}'`
            Size=`ls -il $PWD/$model/$f | awk '{print $6}'`
            if [ $Size == "162" ] || [ $Size == "0" ];then
                echo
                echo "This is Not to Download File, Will be Deleted!"
                echo "File:$File"
                echo "Size:$Size"
                rm $File
            fi
        done
    fi
}

Filter

echo "您打算从哪个版本开始查询（推荐从 40172 [B535] 开始）："
read query_version

for ((i=$query_version;i<99999;i++));do
    echo
    echo "正在查询版本 v$i，若想终止直接关闭窗口"
    echo
    changelog_url="http://update.hicloud.com:8180/TDS/data/files/p3/s15/G1022/g$ml/v$i/f1/full/changelog.xml"
    curl $changelog_url > $PWD/$model/$i.xml

    Filter 1
done

for xml in `find $PWD/$model`;do
    vars=(`basename -s .xml $xml`)
    echo "可下载版本:"
    echo "${vars[$@]}"
done

echo "请输入要下载的版本:"
read var
echo "请选择下载工具: axel curl wget"
read d

update_url="http://update.hicloud.com:8180/TDS/data/files/p3/s15/G$ml/g223/v$var/f1/full/update.zip"


Download(){
    if [ $1 == "axel" ]||[ `which axel` ]; then
        axel -n 16 $update_url
    elif [ $1 == "curl" ]||[ `which curl` ]; then
        curl $update_url
    elif [ $1 == "wget" ]||[ `which wget` ]; then
        wget $update_url
    else
        echo "Not Install $1!"
    fi
}

case $d in
    "axel")
        Download $d
    ;;

    "curl")
        Download $d
    ;;

    "wget")
        Download $d
    ;;
    *)
    ;;