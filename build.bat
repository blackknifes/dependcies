@echo off
where cmake
if %errorlevel% NEQ 0 set path=%path%;C:\Program Files\CMake\bin

where cl
if %errorlevel% NEQ 0 call vcvarsall x86_amd64

if not exist build mkdir build
if not exist build64 mkdir build64

pushd build
cmake -G "Visual Studio 15 2017" --build ..
popd
pushd build64
cmake -G "Visual Studio 15 2017 Win64" --build ..
popd

devenv /BUILD Release "build/*.sln"
devenv /BUILD Release "build64/*.sln"

devenv /BUILD Release /Project "INSTALL" "build/*.sln"
devenv /BUILD Release /Project "INSTALL" "build64/*.sln"

@echo on