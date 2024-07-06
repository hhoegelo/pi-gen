#!/bin/bash -xe

BASE_URL=https://github.com/hhoegelo/mosaik-releases/releases/latest/download/

for PACKAGE in mosaik-app; do
    wget "$BASE_URL/$PACKAGE.deb" -O "${ROOTFS_DIR}/$PACKAGE.deb"
done

git clone https://github.com/stekgreif/mosaik-sample-lib "${ROOTFS_DIR}/home/mosaik/Music/Factory Library"

on_chroot << EOF
    set -x
    dpkg -i mosaik-*.deb
EOF