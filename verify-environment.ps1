#!/usr/bin/env powershell
# GitHub Spec Kit Lab - Verification Script
# Verifica todos los requisitos del laboratorio

Write-Host "`n╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  GitHub Spec Kit Lab - Verification Script               ║" -ForegroundColor Cyan
Write-Host "║  Verificación del Entorno de Desarrollo                  ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

$results = @()

# Function para añadir resultados
function Add-Result {
    param(
        [string]$Component,
        [string]$Required,
        [string]$Installed,
        [bool]$Success,
        [string]$Notes = ""
    )
    
    $status = if ($Success) { "✅" } else { "⚠️" }
    $results += [PSCustomObject]@{
        Component = $Component
        Status = $status
        Required = $Required
        Installed = $Installed
        Notes = $Notes
    }
}

# 1. Verificar Git
Write-Host "📦 Verificando Git..." -ForegroundColor Yellow
try {
    $gitVersion = & git --version
    $gitOK = $gitVersion -match "2\.\d+"
    Add-Result "Git" "2.48+" "$gitVersion" $gitOK
    if ($gitOK) { Write-Host "   ✅ $gitVersion" -ForegroundColor Green }
} catch {
    Add-Result "Git" "2.48+" "No instalado" $false "Instala desde https://git-scm.com"
    Write-Host "   ❌ No detectado" -ForegroundColor Red
}

# 2. Verificar .NET SDK
Write-Host "`n📦 Verificando .NET SDK..." -ForegroundColor Yellow
try {
    $dotnetVersion = & dotnet --version
    $dotnetOK = $dotnetVersion -match "^9\.|^8\."
    Add-Result ".NET SDK" "8.0+" "$dotnetVersion" $dotnetOK
    if ($dotnetOK) { Write-Host "   ✅ $dotnetVersion" -ForegroundColor Green }
} catch {
    Add-Result ".NET SDK" "8.0+" "No instalado" $false "Descarga desde https://dotnet.microsoft.com"
    Write-Host "   ❌ No detectado" -ForegroundColor Red
}

# 3. Verificar Python
Write-Host "`n📦 Verificando Python..." -ForegroundColor Yellow
try {
    $pythonVersion = & python --version
    $pythonOK = $pythonVersion -match "3\.1[1-9]|3\.[2-9][0-9]"
    Add-Result "Python" "3.11+" "$pythonVersion" $pythonOK
    if ($pythonOK) { Write-Host "   ✅ $pythonVersion" -ForegroundColor Green }
} catch {
    Add-Result "Python" "3.11+" "No instalado" $false "Descarga desde https://python.org"
    Write-Host "   ❌ No detectado" -ForegroundColor Red
}

# 4. Verificar UV
Write-Host "`n📦 Verificando UV Package Manager..." -ForegroundColor Yellow
try {
    $uvVersion = & C:\BN\Proyectos\CopilotAdventures\.venv\Scripts\uv.exe --version 2>$null
    if ($uvVersion) {
        Add-Result "UV Manager" "Requerido" "$uvVersion" $true
        Write-Host "   ✅ $uvVersion" -ForegroundColor Green
    }
} catch {
    Add-Result "UV Manager" "Requerido" "No detectado" $false "Ejecuta: pip install uv"
    Write-Host "   ⚠️ No detectado en venv" -ForegroundColor Yellow
}

# 5. Verificar SQL Server LocalDB
Write-Host "`n📦 Verificando SQL Server LocalDB..." -ForegroundColor Yellow
try {
    $sqlLocalDbInstances = & sqllocaldb info
    $hasLocalDb = $sqlLocalDbInstances -like "*MSSQLLocalDB*" -or $sqlLocalDbInstances.Count -gt 0
    Add-Result "SQL Server LocalDB" "Requerido" "Detectado" $hasLocalDb
    if ($hasLocalDb) { Write-Host "   ✅ LocalDB disponible" -ForegroundColor Green }
} catch {
    Write-Host "   ⚠️ No se pudo verificar sqllocaldb" -ForegroundColor Yellow
    Add-Result "SQL Server LocalDB" "Requerido" "Desconocido" $false "Instala SQL Server Express"
}

# 6. Verificar Visual Studio Code
Write-Host "`n📦 Verificando Visual Studio Code..." -ForegroundColor Yellow
try {
    $codeVersion = & code --version 2>$null | Select-Object -First 1
    if ($codeVersion) {
        Add-Result "VS Code" "Requerido" "Instalado" $true "Versión: $codeVersion"
        Write-Host "   ✅ VS Code instalado (v$codeVersion)" -ForegroundColor Green
    }
} catch {
    Add-Result "VS Code" "Requerido" "No detectado" $false "Descarga desde https://code.visualstudio.com"
    Write-Host "   ⚠️ VS Code no detectado en PATH" -ForegroundColor Yellow
}

# 7. Verificar ContosoDashboard
Write-Host "`n📦 Verificando ContosoDashboard..." -ForegroundColor Yellow
$csprojPath = "C:\BN\Proyectos\CopilotAdventures\ContosoDashboard-SSD\ContosoDashboard\ContosoDashboard.csproj"
if (Test-Path $csprojPath) {
    Add-Result "ContosoDashboard" "Requerido" "Clonado" $true "Proyecto disponible"
    Write-Host "   ✅ Proyecto clonado" -ForegroundColor Green
} else {
    Add-Result "ContosoDashboard" "Requerido" "No encontrado" $false "Git clone el repositorio"
    Write-Host "   ❌ Proyecto no encontrado" -ForegroundColor Red
}

# 8. Verificar Git Configuration
Write-Host "`n📦 Verificando Configuración de Git..." -ForegroundColor Yellow
try {
    $gitEmail = & git config --global user.email
    $gitName = & git config --global user.name
    $gitConfigOK = -not [string]::IsNullOrEmpty($gitEmail) -and -not [string]::IsNullOrEmpty($gitName)
    $configDisplay = "$gitName [$gitEmail]"
    Add-Result "Git Config" "Email + Name" $configDisplay $gitConfigOK
    if ($gitConfigOK) {
        Write-Host "   ✅ Configurado: $configDisplay" -ForegroundColor Green
    } else {
        Write-Host "   ⚠️ Git no configurado (configura después si es necesario)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "   ⚠️ No se pudo verificar configuración" -ForegroundColor Yellow
}

# Mostrar resultados en tabla
Write-Host "`n╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  RESULTADOS DE VERIFICACIÓN                               ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

$results | Format-Table -AutoSize

# Calcular score
$totalItems = $results.Count
$passedItems = ($results | Where-Object { $_.Status -eq "✅" }).Count
$score = [math]::Round(($passedItems / $totalItems) * 100)

Write-Host "`n╔════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  PUNTUACIÓN GENERAL                                       ║" -ForegroundColor Cyan
Write-Host "╚════════════════════════════════════════════════════════════╝`n" -ForegroundColor Cyan

Write-Host "Puntuación: $score% ($passedItems/$totalItems componentes listos)" -ForegroundColor Cyan

if ($score -eq 100) {
    Write-Host "`n🎉 ¡LISTO PARA COMENZAR EL LABORATORIO!" -ForegroundColor Green
} elseif ($score -ge 75) {
    Write-Host "`n✅ CASI LISTO - Completa los requisitos faltantes" -ForegroundColor Yellow
} else {
    Write-Host "`n⚠️ CONFIGURACIÓN INCOMPLETA - Instala los componentes faltantes" -ForegroundColor Red
}

Write-Host "`n════════════════════════════════════════════════════════════`n" -ForegroundColor Cyan

# Mostrar instrucciones finales
Write-Host "PRÓXIMOS PASOS:" -ForegroundColor Cyan
Write-Host "1. Instala Visual Studio Code: https://code.visualstudio.com" -ForegroundColor White
Write-Host "2. Instala estas extensiones en VS Code:" -ForegroundColor White
Write-Host "   - C# Dev Kit (ms-dotnettools.csharp)" -ForegroundColor White
Write-Host "   - GitHub Copilot (GitHub.copilot)" -ForegroundColor White
Write-Host "   - GitHub Copilot Chat (GitHub.copilot-chat)" -ForegroundColor White
Write-Host "3. Autentica con GitHub en VS Code" -ForegroundColor White
Write-Host "4. Abre el proyecto:" -ForegroundColor White
Write-Host "   cd C:\BN\Proyectos\CopilotAdventures\ContosoDashboard-SSD" -ForegroundColor White
Write-Host "   code ." -ForegroundColor White
Write-Host "5. Accede a la aplicación:" -ForegroundColor White
Write-Host "   http://localhost:5000" -ForegroundColor White
Write-Host "`n════════════════════════════════════════════════════════════`n" -ForegroundColor Cyan
