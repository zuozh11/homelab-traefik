#!/bin/bash
echo '仅用于初始化,初始化完成后自动启动容器'
echo
echo '开始初始化...'
echo '启动acme容器...'
docker-compose up acme -d
echo '等待5秒容器启动'
sleep 5
echo '切换到Let`s letsencrypt'
docker exec acme.sh --set-default-ca --server letsencrypt
echo '设置更新'
docker exec acme.sh --upgrade --auto-upgrade
echo '生成证书'
docker exec acme.sh --issue --dns dns_dp -d '*.kamipon.com'
echo '安装证书'
docker exec acme.sh --install-cert -d '*.kamipon.com' \
--key-file       /data/cert/kamipon.key  \
--fullchain-file /data/cert/kamipon.crt \
--reloadcmd     "echo '证书安装完成'"
echo '启动所有容器...'
docker-compose up -d
echo '初始化完毕!'