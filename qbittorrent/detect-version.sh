#!/usr/bin/env bash

set -o pipefail

dir_shell=$(cd $(dirname $0); pwd)
dir_myscripts=$(cd $(dirname $0); cd ../../myscripts; pwd)

cd $dir_shell

## 官方版本
ver_qb_official=$(curl -s https://api.github.com/repos/qbittorrent/qBittorrent/tags | jq -r .[0]."name" | sed "s/release-//")
ver_lib_official=$(curl -s https://api.github.com/repos/arvidn/libtorrent/tags | jq -r .[]."name" | grep -m 1 "v1." | sed "s/v//")

## 本地版本
ver_qb_local=$(cat ./qbittorrent.version)
ver_lib_local=$(cat ./libtorrent.version)

## 检测qbittorrent官方版本与本地版本是否一致，如不一致则重新构建
if [[ $ver_qb_official ]] && [[ $ver_lib_official ]]; then
    if [[ $ver_qb_official != $ver_qb_local ]]; then
        echo "官方已升级qBittorrent版本至：$ver_qb_official，开始重新构建镜像..."
        . $dir_myscripts/notify.sh
        . $dir_myscripts/my_config.sh
        curl \
            -X POST \
            -H "Accept: application/vnd.github.v3+json" \
            -H "Authorization: token ${GITHUB_MIRROR_TOKEN}" \
            -d '{"event_type":"mirror"}' \
            https://api.github.com/repos/nevinen/dockerfiles/dispatches
        sleep 2m
        notify "qBittorrent已经升级" "当前官方版本信息如下：\nqBittorrent: ${ver_qb_official}\nlibtorrent: ${ver_lib_official}\n\n当前本地版本信息如下：\nqBittorrent: ${ver_qb_local}\nlibtorrent: ${ver_lib_local}\n\n已自动开始重新构建并推送镜像..."
        start_time=$(date +'%Y-%m-%d %H:%M:%S')
        ./buildx-run.sh "$ver_qb_official" "$ver_lib_official" && {
            echo "$ver_qb_official" > ./qbittorrent.version
            echo "$ver_lib_official" > ./libtorrent.version
            notify "qBittorrent镜像构建成功" "当前版本信息如下：\nqBittorrent: ${ver_qb_official}\nlibtorrent: ${ver_lib_official}\n\n构建时间如下：\n开始时间：${start_time}\n完成时间：$(date +'%Y-%m-%d %H:%M:%S')\n\nhub链接如下：\nhttps://hub.docker.com/repository/docker/nevinee/qbittorrent\nhttps://hub.docker.com/r/nevinee/qbittorrent"
        } || notify "qBittorrent镜像构建失败" "当前官方版本信息如下：\nqBittorrent: ${ver_qb_official}\nlibtorrent: ${ver_lib_official}\n\n当前本地版本信息如下：\nqBittorrent: ${ver_qb_local}\nlibtorrent: ${ver_lib_local}\n\n构建时间如下：\n开始时间：${start_time}\n完成时间：$(date +'%Y-%m-%d %H:%M:%S')"
    else
        echo "qBittorrent官方版本和本地一致，均为：$ver_qb_official"
    fi
fi
