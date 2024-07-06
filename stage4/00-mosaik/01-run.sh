#!/bin/bash -xe

BASE_URL=https://github.com/hhoegelo/mosaik-releases/releases/latest/download/

for PACKAGE in mosaik-app; do
    wget "$BASE_URL/$PACKAGE.deb" -O "${ROOTFS_DIR}/$PACKAGE.deb"
done

DIRECTORY="${ROOTFS_DIR}/home/mosaik/Music/Factory Library"

git clone https://github.com/stekgreif/mosaik-sample-lib "${DIRECTORY}"
rm -rf "${DIRECTORY}/.git"

find "$DIRECTORY" -type f -name '*.wav' | while read -r wavfile; do
  flacfile="${wavfile%.wav}.flac"
  rm -rf "$flacfile"
  flac "$wavfile" -o "$flacfile"

  if [ $? -eq 0 ]; then
    rm "$wavfile"
  else
    echo "Failed to convert: $wavfile"
  fi
done


on_chroot << EOF
    set -x
    dpkg -i mosaik-*.deb
    systemctl unmask mosaik.service
    systemctl enable mosaik.service
EOF