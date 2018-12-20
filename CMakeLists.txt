cmake_minimum_required(VERSION 3.1)

file(DOWNLOAD "https://raw.githubusercontent.com/nlohmann/json/master/single_include/nlohmann/json.hpp" "${CMAKE_CURRENT_SOURCE_DIR}/deps/json/json.hpp"
 INACTIVITY_TIMEOUT 5000 TLS_VERIFY OFF SHOW_PROGRESS)

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