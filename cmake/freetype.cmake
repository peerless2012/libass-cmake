ExternalProject_Add(ep_freetype
        DEPENDS ep_fribidi ep_png
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
        SOURCE_SUBDIR "src/freetype"
        INSTALL_DIR ${CMAKE_BINARY_DIR}
        CMAKE_ARGS ${EXTERNAL_PROJECT_CMAKE_ARGS}
)
include_directories(${CMAKE_BINARY_DIR}/include)
link_directories(${CMAKE_BINARY_DIR}/lib)