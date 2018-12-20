@echo off
set path=%path%;%cd%\tool\curl
set path=%path%;C:\Program Files\CMake\bin
set path=%path%;%cd%\tool\cmake

if not exist deps mkdir deps
if not exist deps\json mkdir deps\json
curl https://raw.githubusercontent.com/nlohmann/json/master/single_include/nlohmann/json.hpp -o deps/json/json.hpp -L -#

set CMAKE_PLATFORM=Visual Studio 15 2017
set CMAKE_DEFINES=-D CARES_BUILD_TESTS:BOOL=fales -D CARES_BUILD_TOOLS:BOOL=false -D CARES_INSTALL:BOOL=true -D CARES_MSVC_STATIC_RUNTIME:BOOL=true -D CARES_SHARED:BOOL=false -D CMAKE_INSTALL_PREFIX:PATH=%cd%\deps\json

git.exe submodule update --progress --init --recursive
cmake.bat c-ares 