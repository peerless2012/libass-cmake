# libass-cmake

Build libass for Android.

## library version
* [png](https://github.com/pnggroup/libpng) [v1.6.44](https://github.com/pnggroup/libpng/releases/tag/v1.6.44)
* [unibreak](https://github.com/adah1972/libunibreak) [v6.1](https://github.com/adah1972/libunibreak/releases/tag/libunibreak_6_1)
* [harfbuzz](https://github.com/harfbuzz/harfbuzz) [v10.1.0](https://github.com/harfbuzz/harfbuzz/releases/tag/10.1.0)
* [fribidi](https://github.com/fribidi/fribidi) [v1.0.16](https://github.com/fribidi/fribidi/releases/tag/v1.0.16)
* [freetype](https://gitlab.freedesktop.org/freetype/freetype) [v2.13.3](https://gitlab.freedesktop.org/freetype/freetype/-/tags/VER-2-13-3)
* [ass](https://github.com/libass/libass) [v0.17.3](https://github.com/libass/libass/releases/tag/0.17.3)

## how to use

### clone and init
`git clone --recurse-submodules https://github.com/peerless2012/libass-cmake.git ./src/main/cpp`

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