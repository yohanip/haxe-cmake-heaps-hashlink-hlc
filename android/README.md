according to
https://developer.android.com/studio/projects/configure-cmake#call-cmake-cli

# Android Environment setup
  1. export var ANDROID_NDK -> usually inside the sdk, tested on 29.0.13113456
  2. 

running:
  1. cmake -B build -G Ninja -DANDROID_ABI=arm64-v8a -DANDROID_PLATFORM=android-21 -DANDROID_NDK=$ANDROID_NDK -DCMAKE_TOOLCHAIN_FILE=$ANDROID_NDK/build/cmake/android.toolchain.cmake