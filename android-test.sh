#!/bin/sh

set -e

lime build android -v -DPLATFORM=android-22
~/dev/android-sdk/platform-tools/adb install -r /home/dam5s/workspace/ninja-pang/export/android/bin/bin/ninja-pang-debug.apk
