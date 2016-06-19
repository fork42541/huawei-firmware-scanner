#!/bin/bash
# @Author:
# @Date:
# @Last Modified by:   anchen
# @Last Modified time:

echo "您打算从哪个版本开始查询（推荐从 40172 [B535] 开始）："
read v

Filter(){
    for f in `ls $PWD/UL00`; do
        Size=`ls -il $PWD/UL00/$f | awk '{print $6}'`
        File=`ls -il $PWD/UL00/$f | awk '{print $10}'`
        if [ $Size == "162" ] || [ $Size == "0" ];then
            echo
            echo "This is Not to Download File, Will be Deleted!"
            echo "File:$File"
            echo "Size:$Size"
            rm $File
        fi
    done
}

Filter

for ((i=$v;i<99999;i++));do
    echo
    echo "正在查询版本 v$i，若想终止直接关闭窗口"
    echo
    changelog_url="http://update.hicloud.com:8180/TDS/data/files/p3/s15/G1018/g223/v$i/f1/full/changelog.xml"
    curl $changelog_url > $PWD/UL00/$i.xml
    rm $PWD/UL00/$i.xml
#    Filter
done

for xml in `find $PWD/UL00`;do
    vars=(`basename -s .xml $xml`)
    echo "可下载版本:"
    echo "${vars[$@]}"
done

echo "请输入要下载的版本:"
read var
echo "请选择下载工具: axel curl wget"
read d

update_url="http://update.hicloud.com:8180/TDS/data/files/p3/s15/G1018/g223/v$var/f1/full/update.zip"

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