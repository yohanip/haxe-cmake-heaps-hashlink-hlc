according to
https://developer.android.com/studio/projects/configure-cmake#call-cmake-cli

cmake \
-H/testcmakelists/folder\
-B/testgenerated/ninja/project/debug/arm64-v8a\
-DANDROID_ABI=arm64-v8a\
-DANDROID_PLATFORM=android-16\
-DANDROID_NDK=android-sdk/ndk/ndk-version\
-DCMAKE_TOOLCHAIN_FILE=android-sdk/ndk/ndk-version/build/cmake/android.toolchain.cmake\
-G Ninja