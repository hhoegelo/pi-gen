#!/bin/bash -xe

BASE_URL=https://github.com/hhoegelo/mosaik-releases/releases/latest/download/

for PACKAGE in mosaik-aarch64-ab-update mosaik-aarch64-ota-update mosaik-aarch64-factory-init mosaik-aarch64-app; do
    wget "$BASE_URL/$PACKAGE.deb" -O "${ROOTFS_DIR}/$PACKAGE.deb"
done

on_chroot << EOF
    set -x
    dpkg -i mosaik-*.deb
EOF