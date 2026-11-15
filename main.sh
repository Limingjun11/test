#!/bin/bash
set -e

export DEBIAN_FRONTEND=noninteractive
sudo apt update
sudo apt install -y wget unzip qemu-utils

# 下载你找到的那个 22.2 版本
wget -c "https://github.com/jqssun/android-lineage-qemu/releases/download/v2025.10.11/UTM-VM-lineage-22.2-20251011-jqssun-virtio_arm64only.zip" -O utm.zip

# 解压并转换
mkdir -p extract
unzip -q utm.zip -d extract

VDA_RAW=$(find extract -name "vda.img")
VDB_RAW=$(find extract -name "vdb.img")

# 转换为 qcow2，体积缩到 1GB 左右
qemu-img convert -f raw -O qcow2 -c "$VDA_RAW" ./vda_arm64only.qcow2
qemu-img convert -f raw -O qcow2 -c "$VDB_RAW" ./vdb_arm64only.qcow2
