set(ZLIB_INCLUDE_DIR "${DEPS_ROOT}/zlib" CACHE STRING "..." FORCE)
set(ZLIB_LIBRARY_DEBUG ${CMAKE_BINARY_DIR}/deps/zlib/Debug/zlibstaticd.lib CACHE STRING "..." FORCE)
set(ZLIB_LIBRARY_RELEASE ${CMAKE_BINARY_DIR}/deps/zlib/Release/zlibstatic.lib CACHE STRING "..." FORCE)