@echo off
rem _ninja_one.bat <src_dir> <build_dir> <logfile> <donefile>
rem SCC ortam degiskeninden okunur.
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars32.bat" >nul
if not exist "%~2\build.ninja" (
  cmake -S "%~1" -B "%~2" -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER_LAUNCHER="%SCC%" -DCMAKE_CXX_COMPILER_LAUNCHER="%SCC%" > "%~3" 2>&1
  if errorlevel 1 ( > "%~4" echo 1 & exit /b 0 )
)
cmake --build "%~2" >> "%~3" 2>&1
> "%~4" echo %errorlevel%
exit /b 0
