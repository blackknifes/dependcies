@echo off
goto env

:build
if not exist build mkdir build
if not exist build64 mkdir build64

pushd build
cmake.exe -G "Visual Studio 15 2017" --build ..
popd
pushd build64
cmake.exe -G "Visual Studio 15 2017 Win64" --build ..
popd

devenv.exe /BUILD Release "build/LibDepdependcies.sln"
devenv.exe /BUILD Release "build64/LibDepdependcies.sln"

devenv.exe /BUILD Release /Project "INSTALL" "build/LibDepdependcies.sln"
devenv.exe /BUILD Release /Project "INSTALL" "build64/LibDepdependcies.sln"
goto end

:env
where cmake
if %errorlevel% NEQ 0 set path=%path%;C:\Program Files\CMake\bin

set vcvarsall=vcvarsall
where %vcvarsall%
if %errorlevel% NEQ 0 set vcvarsall=C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\VC\Auxiliary\Build\vcvarsall.bat
where cl
pushd .
if %errorlevel% NEQ 0 call "%vcvarsall%" x86_amd64
popd
goto build

:end
@echo on