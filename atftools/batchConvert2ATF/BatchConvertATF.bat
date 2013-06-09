@echo off
set PAUSE_ERRORS=1
set PATH=%PATH%;
::set FLAGS=-n 0,0 -q 16
::ANDROID ONLY
::set FLAGS=-c e -r -e

::ALL
set FLAGS=-c -r -e

echo.
echo Starting compressing...

cd %1

for /r %%F in (*.png) do (
	"%~dp0atftool/"png2atf.exe -i "%%F" -o "%%~dpF%%~nF.atf" %FLAGS%
	del "%%F"
)

cd %~dp0

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