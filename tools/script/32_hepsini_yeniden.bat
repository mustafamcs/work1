@echo off
title work1 - hepsini yeniden
call "%~dp031_hepsini_durdur.bat"
ping -n 3 127.0.0.1 >nul
call "%~dp030_hepsini_baslat.bat"
