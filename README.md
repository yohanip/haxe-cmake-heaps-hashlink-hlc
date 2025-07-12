# Haxe project (CMAKE + HEAPS + HASHLINK)
confirmed to run on UBUNTO 20

why? because the doc does not explain the detailed steps to compile and i struggle to compile a simple c project

this project is a barebone to example building a c generated heaps hashlink using cmake

steps
  1. cmake -B cmake-build -G Ninja
  2. cmake --build cmake-build --clean-first
  3. run the prorgram by executing
     cmake-build/HeapsC

# Developer notes
struggling with rpath origin.. sigh..

run this command
`readelf -d cmake-build/HeapsC`

cleaning up
rm -rf cmake-build
cmake -B cmake-build -G Ninja -DCMAKE_CXX_COMPILER=clang++ -DCMAKE_C_COMPILER=clang
cmake --build cmake-build --clean-first -v