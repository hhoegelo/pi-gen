#!/bin/bash -e

on_chroot << EOF

gcc --version
make --version

EOF