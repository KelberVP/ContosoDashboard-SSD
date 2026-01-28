@echo off
REM GitHub Spec Kit Lab - Quick Verification
REM Verifica todos los requisitos del laboratorio

cls
echo.
echo ====================================================================
echo  GitHub Spec Kit Lab - Environment Verification
echo  Verificacion del Entorno de Desarrollo
echo ====================================================================
echo.

setlocal enabledelayedexpansion

set "passed=0"
set "failed=0"

REM ===== GIT =====
echo Checking Git...
git --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Git is installed
    set /a "passed+=1"
) else (
    echo [FAIL] Git not found
    set /a "failed+=1"
)

REM ===== .NET SDK =====
echo Checking .NET SDK...
dotnet --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] .NET SDK is installed
    set /a "passed+=1"
) else (
    echo [FAIL] .NET SDK not found
    set /a "failed+=1"
)

REM ===== PYTHON =====
echo Checking Python...
python --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] Python is installed
    set /a "passed+=1"
) else (
    echo [FAIL] Python not found
    set /a "failed+=1"
)

REM ===== UV =====
echo Checking UV Package Manager...
C:\BN\Proyectos\CopilotAdventures\.venv\Scripts\uv.exe --version >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] UV is installed
    set /a "passed+=1"
) else (
    echo [FAIL] UV not found
    set /a "failed+=1"
)

REM ===== LOCALDB =====
echo Checking SQL Server LocalDB...
sqllocaldb info >nul 2>&1
if %errorlevel% equ 0 (
    echo [OK] LocalDB is installed
    set /a "passed+=1"
) else (
    echo [WARN] LocalDB status unknown
    set /a "failed+=1"
)

REM ===== CSPROJ =====
echo Checking ContosoDashboard Project...
if exist "C:\BN\Proyectos\CopilotAdventures\ContosoDashboard-SSD\ContosoDashboard\ContosoDashboard.csproj" (
    echo [OK] ContosoDashboard project found
    set /a "passed+=1"
) else (
    echo [FAIL] ContosoDashboard project not found
    set /a "failed+=1"
)

echo.
echo ====================================================================
echo.
echo Results: %passed% OK, %failed% Issues
echo.

if %failed% equ 0 (
    echo STATUS: READY FOR LAB
) else (
    echo STATUS: SETUP NEEDED
)

echo.
echo NEXT STEPS:
echo 1. Install Visual Studio Code
echo 2. Install Extensions: C#, GitHub Copilot, Copilot Chat
echo 3. Configure GitHub authentication
echo 4. Run: cd ContosoDashboard-SSD ^&^& code .
echo 5. Access: http://localhost:5000
echo.
echo ====================================================================
echo.

pause
