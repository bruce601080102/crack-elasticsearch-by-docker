<div align="center">
    <a href="image/about_icon05.png">
        <img src="images/elastic-x-pack.png" alt="Logo" width="80" height="80">
    </a>
    <h3 align="center">Docker ELK:xpack白金資格破解</h3>
</div>

## 專案特色

- [x] 支持8.x
- [x] 支持7.x


## 作業環境
- Ubuntu 20.04
- x86_64

## 前置作業
- `安裝java8`
    ```sh
    sudo apt-get update
    sudo apt-get install openjdk-8-jdk
    java --version
    ```
- `xpack憑證申請或是用本專案的憑證`
    https://register.elastic.co/



## 使用
```sh
git clone https://github.com/bruce601080102/crack-elasticsearch-by-docker.git
cd crack-elasticsearch-by-docker
```
```sh
chmod u+x *.sh
./build.sh 7.15.1
```
`生成位置` > output

## 替換流程

### `(1)建立Elasticsearch`
```sh
cd docker-elk
```
1.啟動服務
``` sh
docker-compose up -d --no-deps --build elasticsearch
```
2.啟動完再停止服務
```sh
docker stop docker-elk_elasticsearch_1
```
3.到系統目錄
```sh
/var/lib/docker/overlay2/
```

4.查找Elasticsearch容器，檔案大響約526MB 

>完整路徑: /var/lib/docker/overlay2/elasticsearch名稱/diff/usr/share/elasticsearch/modules/x-pack-core

```sh
du -B M --max-depth=1 | sort -
```

5.將output中的.jar檔覆蓋至上放方路徑下

6.重啟Elasticsearch
```sh
docker-compose up -d --no-deps --build elasticsearch
```
### `(2)上傳憑證`
```sh
cd license
```
無設定密碼
```sh
curl -XPUT -u user:password 'http://192.168.10.112:9200/_license' -H 'Content-Type: application/json' -d @license.json
```
已密碼
```sh
curl -XPUT -u elastic:123456 'http://192.168.10.112:9200/_license' -H 'Content-Type: application/json' -d @license.json
```
>出現`vaild`字眼，表示更新成功

### `(3)設定密碼`
進入容器
```sh
docker exec -it docker-elk_elasticsearch_1 bash
```
```sh
./bin/elasticsearch-setup-passwords interactive
```
>本專案設定的密碼全部都是123456
### `(4)啟動Kibana`
```sh
docker-compose up -d --no-deps --build kibana
```
