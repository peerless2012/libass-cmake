cmake_minimum_required(VERSION 3.22.1)
include(ExternalProject)

set(EXTERNAL_PROJECT_CMAKE_ARGS
    -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
    -DANDROID_ABI=${ANDROID_ABI}
    -DANDROID_PLATFORM=${ANDROID_PLATFORM}
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}
    -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}
)

include(${CMAKE_TOOLCHAIN_FILE})

# fribidi and unibreak can't match ANDROID_HOST_TAG!!!
if(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)
    set(CMAKE_HOST_SYSTEM_PROCESSOR "x86_64-linux")
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Darwin)
    set(ANDROID_HOST_TAG darwin-x86_64)
    set(CMAKE_HOST_SYSTEM_PROCESSOR "x86_64-darwin")
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Windows)
    set(CMAKE_HOST_SYSTEM_PROCESSOR "x86_64-windows")
endif()

#
# Set some convenience variables.
#
if(VERBOSE)
    set(CONFIGURE_VERBOSE_ARG "--enable-silent-rules")
else()
    set(CONFIGURE_VERBOSE_ARG "--disable-silent-rules")
endif()

#
# Set general variables for later use when building libraries from source using
# configure/make.
#
set(PLATFORM_COMPILE_ENV_CMDS
        AR=${CMAKE_AR}
        "CC=${CMAKE_C_COMPILER} --target=${CMAKE_C_COMPILER_TARGET}"
        "CXX=${CMAKE_CXX_COMPILER} --target=${CMAKE_C_COMPILER_TARGET}"
        NM=${CMAKE_NM}
        OBJDUMP=${CMAKE_OBJDUMP}
        RANLIB=${CMAKE_RANLIB}
        STRIP=${CMAKE_STRIP})

set(PLATFORM_COMPILE_ENV_FLAGS
        "CFLAGS=${CMAKE_C_FLAGS} -fPIC --target=${CMAKE_C_COMPILER_TARGET}"
        "CXXFLAGS=${CMAKE_CXX_FLAGS} -fPIC --target=${CMAKE_CXX_COMPILER_TARGET}"
        "LDFLAGS=${CMAKE_SHARED_LINKER_FLAGS} --target=${CMAKE_C_COMPILER_TARGET}"
)

set(PLATFORM_CONFIGURE_ENV ${PLATFORM_COMPILE_ENV_CMDS}
        ${PLATFORM_COMPILE_ENV_FLAGS})

set(PLATFORM_BUILD_AND_HOST
        "--build=${CMAKE_HOST_SYSTEM_PROCESSOR}"
        "--host=${CMAKE_C_COMPILER_TARGET}"
        "--target=${CMAKE_C_COMPILER_TARGET}"
)

#
# Set variables for later use when building with meson.
#
if(CMAKE_C_ANDROID_TOOLCHAIN_PREFIX)
    string(REGEX REPLACE "-$" "${CMAKE_SYSTEM_VERSION}-clang" CROSS_CC
            ${CMAKE_C_ANDROID_TOOLCHAIN_PREFIX})
endif()
if(CMAKE_CXX_ANDROID_TOOLCHAIN_PREFIX)
    string(REGEX REPLACE "-$" "${CMAKE_SYSTEM_VERSION}-clang++" CROSS_CXX
            ${CMAKE_CXX_ANDROID_TOOLCHAIN_PREFIX})
endif()
if(EXISTS ${PROJECT_SOURCE_DIR}/cmake/files/meson-cross-android.in)
    if(CMAKE_ANDROID_ARCH STREQUAL "arm64")
        set(MESON_SYSTEM_CPU_FAMILY "aarch64")
    else()
        set(MESON_SYSTEM_CPU_FAMILY ${CMAKE_ANDROID_ARCH})
    endif()
    configure_file(${PROJECT_SOURCE_DIR}/cmake/files/meson-cross-android.in
            ${PROJECT_BINARY_DIR}/meson-cross-compile @ONLY)
    unset(MESON_SYSTEM_CPU_FAMILY)
endif()

include(cmake/png.cmake)
include(cmake/unibreak.cmake)
include(cmake/fribidi.cmake)
include(cmake/freetype.cmake)
include(cmake/harfbuzz.cmake)
include(cmake/ass.cmake)