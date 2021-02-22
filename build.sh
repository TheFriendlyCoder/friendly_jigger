#!/bin/bash -e
[ -e "build" ] && rm -rf build 
mkdir build
dotnet publish -c Release -r osx-x64 /p:Version=0.0.1-dev friendly_jigger
mv ./friendly_jigger/bin/Release/net5.0/osx-x64/publish/friendly_jigger ./build