# The Android NDK toolchain ships its own zlib in the sysroot,
# but it does not provide a zlib.pc.
# Since freetype's generated freetype2.pc declares `Requires.private:
# zlib`, pkg-config needs a zlib.pc to resolve that dependency.
set(NDK_ZLIB_HEADER "${CMAKE_SYSROOT}/usr/include/zlib.h")
set(NDK_ZLIB_VERSION "1.0.0")
if(EXISTS ${NDK_ZLIB_HEADER})
    file(STRINGS ${NDK_ZLIB_HEADER} NDK_ZLIB_VERSION_LINE REGEX "#define ZLIB_VERSION ")
    string(REGEX REPLACE ".*#define ZLIB_VERSION \"([^\"]+)\".*" "\\1" NDK_ZLIB_VERSION "${NDK_ZLIB_VERSION_LINE}")
endif()

file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/lib/pkgconfig)
file(WRITE ${CMAKE_BINARY_DIR}/lib/pkgconfig/zlib.pc
"Name: zlib
Description: zlib compression library (provided by the Android NDK toolchain)
Version: ${NDK_ZLIB_VERSION}
Libs: -lz
Cflags:
")

unset(NDK_ZLIB_HEADER)
unset(NDK_ZLIB_VERSION)
unset(NDK_ZLIB_VERSION_LINE)
