cmake_minimum_required(VERSION 3.10)
ExternalProject_Add(ep_ass
        DEPENDS ep_fontconfig ep_harfbuzz ep_freetype ep_fribidi ep_unibreak
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
        SOURCE_SUBDIR "src/ass"
        INSTALL_DIR ${CMAKE_BINARY_DIR}
        CONFIGURE_COMMAND
            PKG_CONFIG_PATH=${CMAKE_BINARY_DIR}/lib/pkgconfig
            FREETYPE_CFLAGS=-I${CMAKE_BINARY_DIR}/include/freetype2 FREETYPE_LIBS=-L${CMAKE_BINARY_DIR}/lib
            FRIBIDI_CFLAGS=-I${CMAKE_BINARY_DIR}/include/fribidi FRIBIDI_LIBS=-L${CMAKE_BINARY_DIR}/lib
            HARFBUZZ_CFLAGS=-I${CMAKE_BINARY_DIR}/include/harfbuzz HARFBUZZ_LIBS=-L${CMAKE_BINARY_DIR}/lib
            LIBUNIBREAK_CFLAGS=-I${CMAKE_BINARY_DIR}/include LIBUNIBREAK_LIBS=-L${CMAKE_BINARY_DIR}/lib
        CONFIGURE_COMMAND
            ${CMAKE_COMMAND} -E env ${PLATFORM_CONFIGURE_ENV}
            <SOURCE_DIR>/<SOURCE_SUBDIR>/configure
            ${PLATFORM_BUILD_AND_HOST} ${CONFIGURE_VERBOSE_ARG}
            --prefix=${CMAKE_BINARY_DIR}
            --enable-shared=false
            --enable-static=yes
            --enable-libunibreak
            --enable-fontconfig
            --srcdir=<SOURCE_DIR>/<SOURCE_SUBDIR>
        BUILD_COMMAND make
        INSTALL_COMMAND make install
)
add_dependencies(ep_ass ep_freetype ep_harfbuzz ep_fribidi ep_unibreak)
include_directories({CMAKE_BINARY_DIR}/include)
link_directories({CMAKE_BINARY_DIR}/lib)