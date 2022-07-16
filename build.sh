#!/bin/bash
if  [ ! "$1" ] ;then
    echo "You have not entered a version"
    exit
fi
version=$1
echo -e "\033[36mRun for version: ${version}\033[0m"


# ==============================step1==============================
mkdir install && cd install

wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${version}-linux-x86_64.tar.gz -O elasticsearch-${version}-linux-x86_64.tar.gz

tar zxvf elasticsearch-${version}-linux-x86_64.tar.gz

cd ..

mkdir src && cd src

wget https://github.com/elastic/elasticsearch/archive/v${version}.tar.gz -O elasticsearch-v${version}.tar.gz

tar zxvf elasticsearch-v${version}.tar.gz
cd ..

mkdir build && cd build

ln -s ../install/elasticsearch-${version}/lib .
ln -s ../install/elasticsearch-${version}/modules .
cd ..

javac -cp "build/lib/elasticsearch-${version}.jar:build/lib/lucene-core-8.9.0.jar:build/modules/x-pack-core/x-pack-core-${version}.jar" LicenseVerifier.java

# ==============================step2==============================

mkdir pack-tmp
mkdir ouptput

now_path=`pwd`
echo =$now_path

cp build/modules/x-pack-core/x-pack-core-${version}.jar pack-tmp

cd pack-tmp

jar -xvf x-pack-core-${version}.jar

rm -rf x-pack-core-${version}.jar

#   刪除原文件，將新編譯的拷貝到該位置
rm -rf org/elasticsearch/license/LicenseVerifier.class
cp ../LicenseVerifier.class org/elasticsearch/license/

#   重新打包
jar -cvf x-pack-core-${version}.jar ./*

mv x-pack-core-${version}.jar  $now_path/ouptput/
cd ..
rm -r pack-tmp/
rm -r build/ install/ src/


