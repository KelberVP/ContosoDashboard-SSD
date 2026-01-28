# ╔════════════════════════════════════════════════════════════════════════════╗
# ║           GitHub Copilot - Spec-Driven Development Initializer              ║
# ║                        Powered by GitHub Copilot AI                          ║
# ╚════════════════════════════════════════════════════════════════════════════╝

param(
    [string]$Mode = "interactive",
    [switch]$Verbose = $false
)

# ═══════════════════════════════════════════════════════════════════════════════
# CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

$ProjectRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$CopilotConfig = @{
    Enabled = $true
    Mode = "copilot"
    ScriptEngine = "PowerShell"
    Version = "1.0"
    InitializedAt = Get-Date
    ProjectRoot = $ProjectRoot
}

$Colors = @{
    Success = "Green"
    Warning = "Yellow"
    Error = "Red"
    Info = "Cyan"
    Prompt = "Magenta"
}

# ═══════════════════════════════════════════════════════════════════════════════
# UTILITY FUNCTIONS
# ═══════════════════════════════════════════════════════════════════════════════

function Write-Section {
    param([string]$Title)
    Write-Host ""
    Write-Host ("=" * 80) -ForegroundColor DarkGray
    Write-Host (">> " + $Title) -ForegroundColor $Colors.Info
    Write-Host ("=" * 80) -ForegroundColor DarkGray
    Write-Host ""
}

function Write-Success {
    param([string]$Message)
    Write-Host "[OK] $Message" -ForegroundColor $Colors.Success
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[!] $Message" -ForegroundColor $Colors.Warning
}

function Write-Error-Custom {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor $Colors.Error
}

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor $Colors.Info
}

function Test-Requirement {
    param(
        [string]$Name,
        [scriptblock]$Test,
        [string]$FixUrl = ""
    )
    
    try {
        $result = & $Test
        if ($result) {
            Write-Success "$Name verificado"
            return $true
        } else {
            Write-Warning "$Name no encontrado"
            if ($FixUrl) { Write-Info "Solución: $FixUrl" }
            return $false
        }
    } catch {
        Write-Error-Custom "$Name error: $_"
        return $false
    }
}

# ═══════════════════════════════════════════════════════════════════════════════
# COPILOT INITIALIZATION
# ═══════════════════════════════════════════════════════════════════════════════

function Initialize-CopilotEnvironment {
    Write-Section "Inicializando Entorno de GitHub Copilot"
    
    # Verificar Visual Studio Code
    Write-Info "Detectando Visual Studio Code..."
    Test-Requirement -Name "Visual Studio Code" -Test {
        $null = Get-Command code -ErrorAction SilentlyContinue
        return $null -ne (Get-Command code -ErrorAction SilentlyContinue)
    } -FixUrl "https://code.visualstudio.com"
    
    # Verificar Extensión Copilot
    Write-Info "Detectando Extensión GitHub Copilot..."
    $vscodeExtDir = "$env:USERPROFILE\.vscode\extensions"
    $copilotExt = Get-ChildItem -Path $vscodeExtDir -Filter "github.copilot*" -ErrorAction SilentlyContinue
    if ($copilotExt) {
        Write-Success "GitHub Copilot Extension instalada"
    } else {
        Write-Warning "GitHub Copilot Extension no detectada"
        Write-Info "Para instalar: Abre VS Code → Ctrl+Shift+X → busca 'GitHub Copilot'"
    }
    
    # Crear .copilotrc
    Write-Info "Creando configuración de Copilot..."
    $copilotrc = @{
        copilot = $CopilotConfig
        sdd = @{
            enabled = $true
            mode = "spec-driven"
            documentationPath = "$ProjectRoot\StakeholderDocs"
        }
        vscode = @{
            extensions = @(
                "github.copilot",
                "github.copilot-chat",
                "ms-dotnettools.csharp",
                "ms-dotnettools.csdevkit"
            )
        }
    }
    
    $copilotrc | ConvertTo-Json | Out-File -Path "$ProjectRoot\.copilotrc" -Encoding UTF8
    Write-Success ".copilotrc creado"
    
    Write-Host ""
}

# ═══════════════════════════════════════════════════════════════════════════════
# PROJECT SETUP
# ═══════════════════════════════════════════════════════════════════════════════

function Initialize-ProjectStructure {
    Write-Section "Configurando Estructura del Proyecto"
    
    # Verificar directorios críticos
    $dirs = @(
        "ContosoDashboard",
        "StakeholderDocs",
        ".vscode",
        ".specify"
    )
    
    foreach ($dir in $dirs) {
        $dirPath = Join-Path -Path $ProjectRoot -ChildPath $dir
        if (Test-Path -Path $dirPath) {
            Write-Success "Directorio $dir verificado"
        } else {
            Write-Warning "Directorio $dir no encontrado"
        }
    }
    
    Write-Host ""
}

# ═══════════════════════════════════════════════════════════════════════════════
# DEVELOPMENT ENVIRONMENT
# ═══════════════════════════════════════════════════════════════════════════════

function Initialize-DevelopmentTools {
    Write-Section "Verificando Herramientas de Desarrollo"
    
    # .NET
    Test-Requirement -Name ".NET SDK" -Test {
        $dotnet = dotnet --version 2>$null
        return $null -ne $dotnet
    }
    
    # Git
    Test-Requirement -Name "Git" -Test {
        $git = git --version 2>$null
        return $null -ne $git
    }
    
    # Python
    Test-Requirement -Name "Python" -Test {
        $python = python --version 2>$null
        return $null -ne $python
    }
    
    # UV
    Test-Requirement -Name "UV Package Manager" -Test {
        $uv = & "$ProjectRoot\..\..\.venv\Scripts\uv.exe" --version 2>$null
        return $null -ne $uv
    }
    
    Write-Host ""
}

# ═══════════════════════════════════════════════════════════════════════════════
# VS CODE CONFIGURATION
# ═══════════════════════════════════════════════════════════════════════════════

function Initialize-VSCodeSettings {
    Write-Section "Configurando Visual Studio Code"
    
    $vscodeDir = Join-Path -Path $ProjectRoot -ChildPath ".vscode"
    if (-not (Test-Path -Path $vscodeDir)) {
        New-Item -ItemType Directory -Path $vscodeDir -Force | Out-Null
        Write-Info "Directorio .vscode creado"
    }
    
    # Crear settings.json con Copilot
    $settings = @{
        "[csharp]" = @{
            "editor.defaultFormatter" = "ms-dotnettools.csharp"
            "editor.formatOnSave" = $true
            "editor.formatOnPaste" = $true
        }
        "github.copilot.enable" = @{
            "*" = $true
            "plaintext" = $false
            "markdown" = $false
        }
        "editor.inlineSuggest.enabled" = $true
        "github.copilot.advanced" = @{
            "debug.overrideChatModel" = ""
            "debug.testOverrideProxyUrl" = ""
            "debug.useInternalProxyUrl" = $true
            "listMaxResults" = 10
        }
        "files.exclude" = @{
            "**/.git" = $true
            "**/node_modules" = $true
            "**/bin" = $true
            "**/obj" = $true
        }
    }
    
    $settings | ConvertTo-Json -Depth 5 | Out-File -Path "$vscodeDir\settings.json" -Encoding UTF8 -Force
    Write-Success "VS Code settings.json configurado con Copilot"
    
    # Crear extensions.json
    $extensions = @{
        recommendations = @(
            "github.copilot",
            "github.copilot-chat",
            "ms-dotnettools.csharp",
            "ms-dotnettools.csdevkit",
            "ms-dotnettools.vscode-dotnet-runtime",
            "ms-dotnettools.csharp-dev-kit",
            "ms-vscode.makefile-tools",
            "github.vscode-pull-request-github"
        )
    }
    
    $extensions | ConvertTo-Json | Out-File -Path "$vscodeDir\extensions.json" -Encoding UTF8 -Force
    Write-Success "VS Code extensions.json creado"
    
    Write-Host ""
}

# ═══════════════════════════════════════════════════════════════════════════════
# COPILOT QUICK START GUIDE
# ═══════════════════════════════════════════════════════════════════════════════

function Show-CopilotGuide {
    Write-Section "GitHub Copilot - Guía Rápida"
    
    Write-Host "SHORTCUTS DISPONIBLES:" -ForegroundColor $Colors.Prompt
    Write-Host ""
    Write-Host "  Ctrl+I           →  Sugerencias inline de código"
    Write-Host "  Ctrl+Shift+I     →  Abrir Copilot Chat"
    Write-Host "  Ctrl+/           →  Comentarios con Copilot"
    Write-Host "  Alt+/            →  Ver más sugerencias"
    Write-Host ""
    
    Write-Host "WORKFLOW SPEC-DRIVEN DEVELOPMENT:" -ForegroundColor $Colors.Prompt
    Write-Host ""
    Write-Host "  1. Lee la especificación (StakeholderDocs/)"
    Write-Host "  2. Abre el archivo relevante"
    Write-Host "  3. Presiona Ctrl+Shift+I para abrir Copilot Chat"
    Write-Host "  4. Describe lo que quieres que haga"
    Write-Host "  5. Copilot genera el código"
    Write-Host "  6. Verifica y ajusta"
    Write-Host "  7. Ejecuta tests"
    Write-Host ""
    
    Write-Host "PROMPTS UTILES:" -ForegroundColor $Colors.Prompt
    Write-Host ""
    Write-Host "  'Genera una clase para manejar [funcionalidad]'"
    Write-Host "  'Crea tests unitarios para esta función'"
    Write-Host "  'Refactoriza este código siguiendo [patrón]'"
    Write-Host "  'Explica qué hace este código'"
    Write-Host "  'Optimiza el rendimiento de esta función'"
    Write-Host ""
}

# ═══════════════════════════════════════════════════════════════════════════════
# MAIN INITIALIZATION
# ═══════════════════════════════════════════════════════════════════════════════

function Invoke-CopilotInitialization {
    Clear-Host
    
    Write-Host ("=" * 80) -ForegroundColor DarkGray
    Write-Host "GITHUB COPILOT SPEC-KIT INITIALIZER" -ForegroundColor Cyan
    Write-Host "Powered by GitHub Copilot Assistant" -ForegroundColor Cyan
    Write-Host ("=" * 80) -ForegroundColor DarkGray
    Write-Host ""
    Write-Info "Directorio de Proyecto: $ProjectRoot"
    Write-Info "Modo: $($CopilotConfig.Mode)"
    Write-Info "Motor de Scripts: $($CopilotConfig.ScriptEngine)"
    Write-Host ""
    
    # Ejecutar inicializaciones
    Initialize-CopilotEnvironment
    Initialize-ProjectStructure
    Initialize-DevelopmentTools
    Initialize-VSCodeSettings
    Show-CopilotGuide
    
    # Resumen
    Write-Section "INICIALIZACION COMPLETADA"
    
    Write-Host "Tu entorno GitHub Copilot Spec-Kit esta listo" -ForegroundColor $Colors.Success
    Write-Host ""
    Write-Host "Proximos pasos:" -ForegroundColor $Colors.Prompt
    Write-Host "  1. Abre el proyecto: code ." -ForegroundColor White
    Write-Host "  2. Autentica Copilot: Ctrl+Shift+P -> 'GitHub Copilot: Sign in'" -ForegroundColor White
    Write-Host "  3. Comienza a codificar con IA" -ForegroundColor White
    Write-Host ""
    
    Write-Host "Documentacion disponible:" -ForegroundColor $Colors.Info
    Write-Host "  * SETUP_COMPLETE.md      - Guia completa de configuracion" -ForegroundColor Gray
    Write-Host "  * PROJECT_ANALYSIS.md    - Analisis de arquitectura" -ForegroundColor Gray
    Write-Host "  * StakeholderDocs/       - Especificaciones de requisitos" -ForegroundColor Gray
    Write-Host ""
    
    Write-Host ("=" * 80) -ForegroundColor DarkGray
    Write-Host "Estado: OPERACIONAL" -ForegroundColor Green
    Write-Host ("=" * 80) -ForegroundColor DarkGray
}

# ═══════════════════════════════════════════════════════════════════════════════
# EXECUTION
# ═══════════════════════════════════════════════════════════════════════════════

if ($PSCmdlet.ParameterSetName -eq $null) {
    Invoke-CopilotInitialization
}
