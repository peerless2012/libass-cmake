ExternalProject_Add(ep_fontconfig
    DEPENDS ep_expat ep_freetype
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
    SOURCE_SUBDIR "src/fontconfig"
    INSTALL_DIR ${CMAKE_BINARY_DIR}
    CONFIGURE_COMMAND
        ${CMAKE_COMMAND} -E env ${PLATFORM_CONFIGURE_ENV}
        <SOURCE_DIR>/<SOURCE_SUBDIR>/configure ${PLATFORM_BUILD_AND_HOST}
        --prefix=<INSTALL_DIR>
        --enable-static
        --disable-shared
    BUILD_COMMAND make
    INSTALL_COMMAND make install
)