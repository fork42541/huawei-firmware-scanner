@echo off
for %%i in (%~dp0\TL00\*.xml)do if %%~zi lss 256 del "%%i" /s /q /f
for %%i in (%~dp0\TL00H\*.xml)do if %%~zi lss 256 del "%%i" /s /q /f
for %%i in (%~dp0\UL00\*.xml)do if %%~zi lss 256 del "%%i" /s /q /f
cls
echo.
echo.
echo.
echo.
echo        �Ѿ����ɸѡ
ping 127.1 -n 2 >nul
exit