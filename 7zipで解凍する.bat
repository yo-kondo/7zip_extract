@echo off

REM 7zipで解凍する
REM このbatファイルに圧縮ファイルをドラッグ＆ドロップすればOK

REM カレントディレクトリをbatファイルのディレクトリに変更
cd /d %~dp0

powershell -NoProfile -ExecutionPolicy RemoteSigned .\7zip_extract.ps1 %1
pause
