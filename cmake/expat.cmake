cmake_minimum_required(VERSION 3.10)
ExternalProject_Add(ep_expat
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
        SOURCE_SUBDIR "src/expat/expat"
        INSTALL_DIR ${CMAKE_BINARY_DIR}
        CONFIGURE_COMMAND
        ${CMAKE_COMMAND} -E env ${PLATFORM_CONFIGURE_ENV}
        <SOURCE_DIR>/<SOURCE_SUBDIR>/configure ${PLATFORM_BUILD_AND_HOST} -prefix=<INSTALL_DIR> --enable-static --disable-shared --without-tests --without-docbook
        BUILD_COMMAND make
        INSTALL_COMMAND make install
)
include_directories(${CMAKE_BINARY_DIR}/include)
link_directories(${CMAKE_BINARY_DIR}/lib)