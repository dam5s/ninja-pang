#!/bin/sh

set -e

lime build android -v -DPLATFORM=android-22
~/dev/android-sdk/platform-tools/adb install -r /home/dam5s/workspace/open-pang/export/android/bin/bin/open-pang-debug.apk
