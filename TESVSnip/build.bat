@echo off
pushd "%~dp0"
msbuild tesvsnip.csproj /p:Configuration=Release /p:Platform="AnyCPU" /t:version_force,build,package
popd