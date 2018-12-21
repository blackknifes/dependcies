cmake_minimum_required(VERSION 3.1)
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include("functions")

set(CMAKE_STATIC_LINKER_FLAGS "${CMAKE_STATIC_LINKER_FLAGS} /NODEFAULTLIB")

set(ZLIB_URL "http://www.zlib.net/zlib1211.zip")
set(ZLIB_VERSION "1.2.11")
set(JSON_URL "https://raw.githubusercontent.com/nlohmann/json/master/single_include/nlohmann/json.hpp")

set(CMAKE_CONFIGURATION_TYPES Debug Release CACHE STRING "..." FORCE)
set(DEPS_SLN_ROOT "${CMAKE_CURRENT_SOURCE_DIR}")
set(DEPS_ROOT "${DEPS_SLN_ROOT}/deps")

set(ARES_ROOT "${DEPS_ROOT}/c-ares")
set(JSON_ROOT "${DEPS_ROOT}/json")
set(MBEDTLS_ROOT "${DEPS_ROOT}/mbedtls")
set(STB_ROOT "${DEPS_ROOT}/stb")
set(BASE64_ROOT "${DEPS_ROOT}/base64")

set(CMAKE_INSTALL_PREFIX "${DEPS_SLN_ROOT}/out" CACHE PATH "..." FORCE)
set(INSTALL_BIN_PREFIX "${CMAKE_INSTALL_PREFIX}/bin" CACHE PATH "...")
set(INSTALL_INC_PREFIX "${CMAKE_INSTALL_PREFIX}/include" CACHE PATH "...")
set(INSTALL_LIB_PREFIX "${CMAKE_INSTALL_PREFIX}/lib" CACHE PATH "...")
set(INSTALL_MAN_PREFIX "${CMAKE_INSTALL_PREFIX}/man" CACHE PATH "...")
set(INSTALL_PKGCONFIG_PREFIX "${CMAKE_INSTALL_PREFIX}/pkgconfig" CACHE PATH "...")

DownloadLibraryZip("zlib" ${ZLIB_URL} "zlib-${ZLIB_VERSION}")
DownloadHPPFile(${JSON_URL} "${CMAKE_CURRENT_SOURCE_DIR}/deps/json/json.hpp")

set(CARES_STATIC ON CACHE BOOL "...")
set(CARES_SHARED OFF CACHE BOOL "...")
set(CARES_INSTALL ON CACHE BOOL "...")
set(CARES_BUILD_TOOLS OFF CACHE BOOL "...")
set(CARES_MSVC_STATIC_RUNTIME ON CACHE BOOL "...")

CheckRuntime()
SupportMultiThreadBuild()

add_subdirectory("deps/zlib")
include("zlib")
include("stb")
include("base64")
add_subdirectory("deps/c-ares")
add_subdirectory("deps/mbedtls")
add_dependencies("mbedtls" "zlib")