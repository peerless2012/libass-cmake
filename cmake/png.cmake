ExternalProject_Add(ep_png
        SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}
        SOURCE_SUBDIR "src/png"
        INSTALL_DIR ${CMAKE_BINARY_DIR}
        CMAKE_ARGS ${EXTERNAL_PROJECT_CMAKE_ARGS} -DPNG_SHARED=OFF
)
include_directories(${CMAKE_BINARY_DIR}/include)
link_directories(${CMAKE_BINARY_DIR}/lib)