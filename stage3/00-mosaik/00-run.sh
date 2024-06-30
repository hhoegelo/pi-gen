#!/bin/bash -xe

BASE_URL=https://github.com/hhoegelo/mosaik-releases/releases/latest/download/

for PACKAGE in mosaik-ab-update mosaik-ota-update; do
    wget "$BASE_URL/$PACKAGE.deb" -O "${ROOTFS_DIR}/$PACKAGE.deb"
done

on_chroot << EOF
    set -x
    dpkg -i mosaik-*.deb
EOF