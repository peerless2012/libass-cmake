ExternalProject_Add(ep_fontconfig
        DEPENDS ep_expat ep_freetype
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
        SOURCE_SUBDIR "src/fontconfig"
        INSTALL_DIR ${CMAKE_BINARY_DIR}
        CONFIGURE_COMMAND
        ${CMAKE_COMMAND} -E env ${PLATFORM_CONFIGURE_ENV}
        <SOURCE_DIR>/<SOURCE_SUBDIR>/configure ${PLATFORM_BUILD_AND_HOST}
        --prefix=<INSTALL_DIR>
        --enable-static --disable-shared
        --with-expat-includes=${CMAKE_BINARY_DIR}/include
        --with-expat-lib=${CMAKE_BINARY_DIR}/lib
        --with-freetype-config=${CMAKE_BINARY_DIR}/bin/freetype-config
        BUILD_COMMAND make
        INSTALL_COMMAND make install
)