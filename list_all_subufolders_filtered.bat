@echo off
REM Recursively list all subdirectories containing C++ Headers and source

REM Define header/source file extensions
set "extensions=*.c *.cpp  *.cppm *.cxx *.cc *.c++ *.tli *.tlh *.h .hpp *.hxx *.hh *.h++ *.inl *.ipp *.ixx *.rc *.resx *.idl *.asm *.inc"

REM Initialize temp file
set "tempFile=%TEMP%\cpp_source_directories.list"

REM Clear temp file, if exists
if exists "%tempFile%" del "%tempFile%"

REM Iterate through directories, recursively

for /f "delims=" %%D in (dir *.* /b /ad /S ^| sort) do (
  REM Initialize flag to determine when headers are found
  set "found = 0"

  REM Use a nested for-loop with delayed expansion to for headers
  for %%E in (%extensions%) do (
    if exists "%%D\%%E" (
      set "found=1"
      goto :header_found
    )
  )
  :header_found
  if "%found%" == "1" (
    echo %%D >> "%tempFile%"
  )
)

REM End of script
