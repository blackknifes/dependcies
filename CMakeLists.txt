cmake_minimum_required(VERSION 3.1)

set(ZLIB_URL "http://www.zlib.net/zlib1211.zip")
set(ZLIB_VERSION "1.2.11")
set(JSON_URL "https://raw.githubusercontent.com/nlohmann/json/master/single_include/nlohmann/json.hpp")

function (DownloadLibraryZip name url rootdir)
    message(STATUS "download ${name} from ${url} .......")
    file(DOWNLOAD ${url} "${TEMP_PATH}/${name}.zip" INACTIVITY_TIMEOUT 5000 TLS_VERIFY OFF SHOW_PROGRESS )

    message(STATUS "unzip ${name}.zip ..............")
    file(REMOVE_RECURSE "${CMAKE_CURRENT_SOURCE_DIR}/deps/${name}")
    execute_process(COMMAND ${UNZIP_EXE} "${TEMP_PATH}/${name}.zip" -d "${CMAKE_CURRENT_SOURCE_DIR}/deps" OUTPUT_QUIET)
    if(rootdir)
        file(RENAME "${CMAKE_CURRENT_SOURCE_DIR}/deps/${rootdir}" "${CMAKE_CURRENT_SOURCE_DIR}/deps/${name}")
    endif()
    message(STATUS "download ${name} success.")
endfunction()

set(TEMP_PATH "${CMAKE_CURRENT_SOURCE_DIR}/temp")
set(UNZIP_EXE "${CMAKE_CURRENT_SOURCE_DIR}/tool/unzip.exe")
DownloadLibraryZip("zlib" ${ZLIB_URL} "zlib-${ZLIB_VERSION}")

file(DOWNLOAD ${JSON_URL} "${CMAKE_CURRENT_SOURCE_DIR}/deps/json/json.hpp" INACTIVITY_TIMEOUT 5000 TLS_VERIFY OFF SHOW_PROGRESS)

set(CMAKE_CONFIGURATION_TYPES Debug Release)
set(DEPS_SLN_ROOT "${CMAKE_CURRENT_SOURCE_DIR}")
set(DEPS_ROOT "${DEPS_SLN_ROOT}/deps")

set(ARES_ROOT "${DEPS_ROOT}/c-ares")
set(JSON_ROOT "${DEPS_ROOT}/json")
set(MBEDTLS_ROOT "${DEPS_ROOT}/mbedtls")
set(STB_ROOT "${DEPS_ROOT}/stb")
set(BASE64_ROOT "${DEPS_ROOT}/base64")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${DEPS_SLN_ROOT}/cmake")

set(CMAKE_INSTALL_PREFIX "${DEPS_SLN_ROOT}/out" CACHE PATH "...")
set(CARES_STATIC ON CACHE BOOL "...")
set(CARES_SHARED OFF CACHE BOOL "...")
set(CARES_INSTALL ON CACHE BOOL "...")
set(CARES_BUILD_TOOLS OFF CACHE BOOL "...")
set(CARES_MSVC_STATIC_RUNTIME ON CACHE BOOL "...")

include("stb")
include("base64")
# add_subdirectory("deps/c-ares")
# add_subdirectory("deps/mbedtls")