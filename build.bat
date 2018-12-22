@echo off
where cmake
if %errorlevel% NEQ 0 set path=%path%;C:\Program Files\CMake\bin

where cl
if %errorlevel% NEQ 0 call vcvarsall x86_amd64
where cl
if %errorlevel% NEQ 0 call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\vcvarsall x86_amd64"

where devenv
if %errorlevel% NEQ 0 set path=%path%;C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\Common7\IDE

if not exist build mkdir build
if not exist build64 mkdir build64

pushd build
cmake -G "Visual Studio 15 2017" --build ..
popd
pushd build64
cmake -G "Visual Studio 15 2017 Win64" --build ..
popd

devenv /BUILD Release "build/LibDepdependcies.sln"
devenv /BUILD Release "build64/LibDepdependcies.sln"

devenv /BUILD Release /Project "INSTALL" "build/LibDepdependcies.sln"
devenv /BUILD Release /Project "INSTALL" "build64/LibDepdependcies.sln"

@echo on