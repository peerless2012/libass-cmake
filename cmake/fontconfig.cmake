ExternalProject_Add(ep_fontconfig
    DEPENDS ep_expat ep_freetype
    SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
    SOURCE_SUBDIR "src/fontconfig"
    INSTALL_DIR ${CMAKE_BINARY_DIR}
    CONFIGURE_COMMAND
        ${CMAKE_COMMAND} -E env ${PLATFORM_CONFIGURE_ENV}
        # m4/va_copy.m4 AC_RUN_IFELSE has no cross-compiling fallback.
        # Due to that, the check fails with: 
        #   checking for va_copy() function... configure: error: in `PATH/libass-cmake/build/ep_fontconfig-prefix/src/ep_fontconfig-build':
        #   configure: error: cannot run test program while cross compiling
        # To avoid this failure, set its cache variable to skip the runtime check.
        # The NDK toolchain always provides C99 va_copy().
        ac_cv_va_copy=C99
        <SOURCE_DIR>/<SOURCE_SUBDIR>/configure ${PLATFORM_BUILD_AND_HOST}
        --prefix=<INSTALL_DIR>
        --enable-static
        --disable-shared
        --with-pic
    BUILD_COMMAND make
    INSTALL_COMMAND make install
)