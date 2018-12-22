@echo off
echo remove build files......
if exist build rmdir /S /Q build
if exist build64 rmdir /S /Q build64
if exist out rmdir /S /Q out
if exist out64 rmdir /S /Q out64
if exist temp rmdir /S /Q temp
echo success.
@echo on