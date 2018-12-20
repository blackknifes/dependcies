@echo off
vcvarsall %1
devenv /BUILD Release Depdencies.sln
@echo on