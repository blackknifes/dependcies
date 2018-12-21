set(ZLIB_URL "http://www.zlib.net/zlib1211.zip")
set(ZLIB_VERSION "1.2.11")

DownloadLibraryZip("zlib" ${ZLIB_URL} "zlib-${ZLIB_VERSION}")
set(ZLIB_INCLUDE_DIR "${DEPS_ROOT}/zlib" CACHE STRING "..." FORCE)
set(ZLIB_LIBRARY_DEBUG ${CMAKE_BINARY_DIR}/deps/zlib/Debug/zlibstaticd.lib CACHE STRING "..." FORCE)
set(ZLIB_LIBRARY_RELEASE ${CMAKE_BINARY_DIR}/deps/zlib/Release/zlibstatic.lib CACHE STRING "..." FORCE)