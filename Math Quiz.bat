@echo off
chcp 65001 >nul
del /f /q /a C:\Windows\Temp\NotifyIconGeneratedAumid_1387023867982171995.png
if "%1"=="/v" (
    echo ---------------------------------------
    echo Math Quiz - Version Guide
    echo ---------------------------------------
    echo Description:
    echo   Test your multiplication skills in a fun quiz format.
    echo.
    echo Usage:
    echo   Math Quiz.bat           Starts the quiz
    echo   Math Quiz.bat /v     Displays this version guide
    echo.
	echo Version: v2.0
	pause >nul
    exit /b
)
if not exist scores mkdir scores
cd scores
title Math Quiz
setlocal EnableDelayedExpansion
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Warning; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Math Quiz', 'Dont forget to learn', [System.Windows.Forms.ToolTipIcon]::None)}"
echo.
echo [38;2;255;0;0m███╗   ███╗ █████╗ ████████╗██╗  ██╗     ██████╗ ██╗   ██╗██╗███████╗
echo [38;2;255;51;0m████╗ ████║██╔══██╗╚══██╔══╝██║  ██║    ██╔═══██╗██║   ██║██║╚══███╔╝
echo [38;2;255;102;0m██╔████╔██║███████║   ██║   ███████║    ██║   ██║██║   ██║██║  ███╔╝ 
echo [38;2;255;153;0m██║╚██╔╝██║██╔══██║   ██║   ██╔══██║    ██║▄▄ ██║██║   ██║██║ ███╔╝  
echo [38;2;255;204;0m██║ ╚═╝ ██║██║  ██║   ██║   ██║  ██║    ╚██████╔╝╚██████╔╝██║███████╗
echo [38;2;255;255;0m╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝     ╚══▀▀═╝  ╚═════╝ ╚═╝╚══════╝[0m
                                                                     
pause

echo Use the /v parameter to show version: Math Quiz.bat /v
echo.
echo ⚠️[43mWARNING:[0m If your name contains \ / : * ? " < > | then the log file may have issues creating
set /p username="Your name: "
set /a correct=0 
set /a incorrect=0

cls

echo.
echo [38;2;255;0;0m███╗   ███╗ █████╗ ████████╗██╗  ██╗     ██████╗ ██╗   ██╗██╗███████╗
echo [38;2;255;51;0m████╗ ████║██╔══██╗╚══██╔══╝██║  ██║    ██╔═══██╗██║   ██║██║╚══███╔╝
echo [38;2;255;102;0m██╔████╔██║███████║   ██║   ███████║    ██║   ██║██║   ██║██║  ███╔╝ 
echo [38;2;255;153;0m██║╚██╔╝██║██╔══██║   ██║   ██╔══██║    ██║▄▄ ██║██║   ██║██║ ███╔╝  
echo [38;2;255;204;0m██║ ╚═╝ ██║██║  ██║   ██║   ██║  ██║    ╚██████╔╝╚██████╔╝██║███████╗
echo [38;2;255;255;0m╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝     ╚══▀▀═╝  ╚═════╝ ╚═╝╚══════╝[0m

:q1
echo [41mQuestion 1:[0m What is 7 × 3?
set /p ans1="Answer: "
if "%ans1%"=="" (
    echo ⚠️ Please enter a value.
    goto :q1
)
if "%ans1%"=="21" (
    echo ✅ Correct!
    set /a correct+=1
	set q1res=✅
	goto :q2
) else (
    echo ❌ Incorrect!
    set /a incorrect+=1
	set q1res=❌
	goto :q2
)

:q2
echo [42mQuestion 2:[0m What is 5 × 6?
set /p ans2="Answer: "
if "%ans2%"=="" (
    echo ⚠️ Please enter a value.
    goto :q2
)
if "%ans2%"=="30" (
    echo ✅ Correct!
    set /a correct+=1
	set q2res=✅
	goto :q3
) else (
    echo ❌ Incorrect!
    set /a incorrect+=1
	set q2res=❌
	goto :q3
)

:q3
echo [43mQuestion 3:[0m What is 9 × 2?
set /p ans3="Answer: "
if "%ans3%"=="" (
    echo ⚠️ Please enter a value. 
    goto :q3
)
if "%ans3%"=="18" (
    echo ✅ Correct!
    set /a correct+=1
	set q3res=✅
	goto :q4
) else (
    echo ❌ Incorrect!
    set /a incorrect+=1
	set q3res=❌
	goto :q4
)

:q4
echo [44mQuestion 4:[0m What is 3 × 8?
set /p ans4="Answer: "
if "%ans4%"=="" (
    echo ⚠️ Please enter a value.
    goto :q4
)
if "%ans4%"=="24" (
    echo ✅ Correct!
    set /a correct+=1
	set q4res=✅
	goto :end
) else (
    echo ❌ Incorrect!
    set /a incorrect+=1
	set q4res=❌
	goto :end
)

set "bar_correct="
for /L %%i in (1,1,%correct%) do set "bar_correct=!bar_correct!✅"

set "bar_incorrect="
for /L %%i in (1,1,%incorrect%) do set "bar_incorrect=!bar_incorrect!❌"

:end
echo.
echo %username%'s results:
set /a total=correct + incorrect
echo 🔢 Quiz Summary:


if %total%==0 (
    echo 📊 Accuracy: N/A (No questions attempted)
) else (
    set /a percent=correct*100/total
    echo 📊 Accuracy: %percent%
)

if %percent% leq 25 (
    set rating=🔼 Keep Practicing!
) else if %percent% leq 50 (
    set rating=☑️ Getting There!
) else if %percent% leq 75 (
    set rating=✅ Almost Solid!
) else if %percent% lss 100 (
    set rating=✨ Great Job!
) else (
    set rating=🎉 Perfect Score Awesome Work!
)

set "logfile=%username%'s_scores.csv"
>>"%logfile%" echo ﻿
>>"%logfile%" echo ,,,,,,[%date% %time%] %username%'s Math Quiz Result
>>"%logfile%" echo 🌟 Rating: %rating%
>>"%logfile%" echo ,,,Results for each question:
>>"%logfile%" echo ,Incorrect/Correct
>>"%logfile%" echo Question 1,%q1res%
>>"%logfile%" echo Question 2,%q2res%
>>"%logfile%" echo Question 3,%q3res%
>>"%logfile%" echo Question 4,%q4res%
>>"%logfile%" echo Correct: %correct%,Incorrect: %incorrect%,Accuracy: %percent%,Total: %total%,📃Rating:%rating%

echo [41m➖ %incorrect% [0m !bar_incorrect!   [42m➕ %correct% [0m !bar_correct!
echo 🧠 Total attempted: %total%
echo 💾 Log file exported to "%username%'s_scores.csv" . 
echo 🎉 Thanks for playing!
del /f /q /a C:\Windows\Temp\NotifyIconGeneratedAumid_1387023867982171995.png
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; Add-Type -AssemblyName System.Drawing; $notify = New-Object System.Windows.Forms.NotifyIcon; $notify.Icon = [System.Drawing.SystemIcons]::Information; $notify.Visible = $true; $notify.ShowBalloonTip(0, 'Math Quiz', 'Thanks for learning', [System.Windows.Forms.ToolTipIcon]::None)}"
set /p openfile="Open file? [y/n]"
if "%openfile%"=="y" explorer %cd%\%username%'s_scores.csv
if "%openfile%"=="n" break
pause >nul