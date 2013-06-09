@echo off
set PAUSE_ERRORS=1
set PATH=%PATH%;

::set FLAGS=-n 0,0 -q 16
::ANDROID ONLY
::set FLAGS=-c e -r -e

::ALL
set FLAGS=-c -r -e

echo %TEXTURE_PACKER_PATH%;
echo.
echo Starting compressing...

cd %1
for %%X in (*.png) do ("C:\Program Files (x86)\CodeAndWeb\TexturePacker\bin\TexturePacker.exe" --padding 0 --disable-rotation --algorithm Basic --opt RGBA8888  --sheet C:\Users\Apollo\Documents\ATF_showcase_app\bin\assets\%%X C:\Users\Apollo\Documents\ATF_showcase_app\bin\assets\%%X)

echo.
if errorlevel 1 goto error
goto end

:error
pause

:end
echo.
echo Complete compress
echo.
pause