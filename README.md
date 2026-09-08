# libass-cmake

Build libass for Android.

## library version
* [unibreak](https://github.com/adah1972/libunibreak) [v7.0](https://github.com/adah1972/libunibreak/releases/tag/libunibreak_7_0)
* [harfbuzz](https://github.com/harfbuzz/harfbuzz) [v14.4.0](https://github.com/harfbuzz/harfbuzz/releases/tag/14.4.0)
* [fribidi](https://github.com/fribidi/fribidi) [v1.0.16](https://github.com/fribidi/fribidi/releases/tag/v1.0.16)
* [freetype](https://gitlab.freedesktop.org/freetype/freetype) [v2.14.3](https://gitlab.freedesktop.org/freetype/freetype/-/tags/VER-2-14-3)
* [expat](https://github.com/libexpat/libexpat) [2.8.4](https://github.com/libexpat/libexpat/releases/tag/R_2_8_4)
* [fontconfig](https://gitlab.freedesktop.org/fontconfig/fontconfig) [v2.18.3](https://gitlab.freedesktop.org/fontconfig/fontconfig/-/tags/2.18.3)
* [ass](https://github.com/libass/libass) [v0.17.5](https://github.com/libass/libass/releases/tag/0.17.5)

## how to use

### clone and init
`git clone --recurse-submodules https://github.com/peerless2012/libass-cmake.git ./src/main/cpp`

### prepare
* make sure you have `libtool`
* make sure you hav `perl`
* install `autopoint`
* install `ninja-build`

### autogen
```
cd ./src/unibreak && NOCONFIGURE=1 ./autogen.sh && cd -
cd ./src/fribidi && NOCONFIGURE=1 ./autogen.sh && cd -
cd ./src/fontconfig && NOCONFIGURE=1 ./autogen.sh && cd -
cd ./src/expat/expat && ./buildconf.sh && cd -
cd ./src/ass && ./autogen.sh && cd -
```

### add ass cmake to CMakeList.txt 
```
cmake_minimum_required(VERSION 3.22.1)

# add ass cmake folder
add_subdirectory(libass-cmake)

project("libass")
include_directories(${CMAKE_BINARY_DIR}/include)
add_library(${CMAKE_PROJECT_NAME} SHARED native-lib.c)
# add target dependence
add_dependencies(${CMAKE_PROJECT_NAME} ep_ass)
target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC ${CMAKE_BINARY_DIR}/include)
target_link_directories(${CMAKE_PROJECT_NAME} PUBLIC ${CMAKE_BINARY_DIR}/lib)
# add .a lib to project
target_link_libraries(${CMAKE_PROJECT_NAME}
        "-Wl,--whole-archive" ass fribidi freetyped harfbuzz unibreak png "-Wl,--no-whole-archive"
        android
        z
        log)
```