@echo off
set /p startnum=��������ĸ��汾��ʼ��ѯ���Ƽ��� 40172 [B535] ��ʼ����
for /l %%i in (%startnum%,1,99999) do (
    cls
    echo.
    echo.
    echo.
    echo.
    echo                   ���ڲ�ѯ�汾 v%%i��������ֱֹ�ӹرմ���
    echo.
    echo.
    echo.
    echo.
    echo.
    curl\curl http://update.hicloud.com:8180/TDS/data/files/p3/s15/G1021/g223/v%%i/f1/full/changelog.xml > %~dp0\TL00\%%i.xml
)
pause