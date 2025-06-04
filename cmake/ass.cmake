cmake_minimum_required(VERSION 3.10)
ExternalProject_Add(ep_ass
    DEPENDS ep_fontconfig ep_harfbuzz ep_freetype ep_fribidi ep_unibreak ep_png
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
    SOURCE_SUBDIR "src/ass"
    INSTALL_DIR ${CMAKE_BINARY_DIR}
    CONFIGURE_COMMAND
        ${CMAKE_COMMAND} -E env ${PLATFORM_CONFIGURE_ENV}
        <SOURCE_DIR>/<SOURCE_SUBDIR>/configure
        ${PLATFORM_BUILD_AND_HOST} ${CONFIGURE_VERBOSE_ARG}
        --prefix=<INSTALL_DIR>
        --enable-static
        --disable-shared
        --enable-fontconfig
        --srcdir=<SOURCE_DIR>/<SOURCE_SUBDIR>
    BUILD_COMMAND ${MAKE_EXECUTABLE} ${MAKE_JFLAG}
)
add_dependencies(ep_ass ep_freetype ep_harfbuzz ep_fribidi ep_unibreak ep_png)
include_directories({CMAKE_BINARY_DIR}/include)
link_directories({CMAKE_BINARY_DIR}/lib)