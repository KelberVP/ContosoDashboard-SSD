# 🎓 Laboratorio GitHub Spec Kit - Entorno Completamente Configurado

**Fecha:** 28 de enero de 2026  
**Estado:** ✅ **LISTO PARA COMENZAR**

---

## ✅ Requisitos del Laboratorio - VERIFICACIÓN COMPLETA

### 1. 🔧 Herramientas del Sistema

| Herramienta | Versión Requerida | Versión Instalada | Status |
|------------|------------------|------------------|--------|
| **Git** | 2.48+ | 2.49.1 | ✅ CUMPLE |
| **.NET SDK** | 8.0+ | 9.0.301 | ✅ CUMPLE |
| **Python** | 3.11+ | 3.13.3 | ✅ CUMPLE |
| **SQL Server LocalDB** | - | ✅ Funcional | ✅ CUMPLE |

### 2. 📦 Gestores de Paquetes y Python

| Componente | Status | Detalles |
|-----------|--------|---------|
| **UV Package Manager** | ✅ INSTALADO | v0.9.27 |
| **Python Virtual Environment** | ✅ CONFIGURADO | .venv creado |

### 3. 🎨 Desarrollo Visual

| Componente | Status | Notas |
|-----------|--------|-------|
| **Visual Studio Code** | ⏳ Verificar | Visita https://code.visualstudio.com |
| **C# Dev Kit Extension** | ⏳ Instalar | Abrir VS Code y buscar en Marketplace |
| **GitHub Copilot Extension** | ⏳ Instalar | Abrir VS Code y buscar en Marketplace |
| **GitHub Copilot Chat** | ⏳ Instalar | Abrir VS Code y buscar en Marketplace |

### 4. 🔐 Autenticación GitHub

| Requisito | Status |
|-----------|--------|
| Cuenta GitHub activa | ⏳ Verificar |
| GitHub Copilot suscripción | ⏳ Verificar |
| VS Code autenticado | ⏳ Configurar |

---

## 🚀 Verificación Detallada de Herramientas

### Git
```
✅ Versión: 2.49.1.windows.1
✅ Requisito: 2.48 o superior
✅ Status: CUMPLE PERFECTAMENTE

Ubicación: System PATH
Uso: Control de versiones y repositorios
```

### .NET SDK
```
✅ Versión: 9.0.301
✅ Requisito: 8.0 o superior
✅ Status: CUMPLE PERFECTAMENTE

Ubicación: C:\Program Files\dotnet
Uso: Compilación y ejecución de aplicaciones ASP.NET Core
```

### Python
```
✅ Versión: 3.13.3
✅ Requisito: 3.11 o superior
✅ Status: CUMPLE PERFECTAMENTE

Ubicación: System PATH
Virtual Environment: C:\BN\Proyectos\CopilotAdventures\.venv
```

### SQL Server LocalDB
```
✅ Status: FUNCIONAL
✅ Base de datos: ContosoDashboard
✅ Tablas: 7 creadas y funcionales
✅ Datos de ejemplo: Cargados

Uso: Persistencia de datos para la aplicación
```

### UV Package Manager
```
✅ Versión: 0.9.27 (b5797b2ab 2026-01-26)
✅ Status: INSTALADO Y FUNCIONAL
✅ Ubicación: .venv\Scripts\uv.exe

Características:
- Gestor de paquetes Python ultrarrápido
- Instalación de dependencias
- Manejo de entornos virtuales
```

---

## 📋 Estado de la Aplicación ContosoDashboard

```
✅ Repositorio clonado desde GitHub
✅ Dependencias restauradas
✅ Proyecto compilado exitosamente
✅ Base de datos LocalDB creada
✅ Datos de prueba precargados
✅ Aplicación ejecutada y probada

URL de acceso: http://localhost:5000
Ambiente: Development
Status: OPERACIONAL
```

### Usuarios de Prueba Disponibles

| Email | Rol | Departamento |
|-------|-----|--------------|
| admin@contoso.com | Administrator | IT |
| camille.nicole@contoso.com | Project Manager | Engineering |
| floris.kregel@contoso.com | Team Lead | Engineering |
| ni.kang@contoso.com | Software Engineer | Engineering |

---

## 🎯 Pasos Finales - Completar Configuración

### Paso 1: Instalar/Verificar Visual Studio Code (5 min)

```powershell
# Verificar si VS Code está instalado
code --version

# Si no está instalado:
# Descarga desde: https://code.visualstudio.com/
# Instala con opciones por defecto
```

### Paso 2: Instalar Extensiones en VS Code (10 min)

**Opción A: Desde UI de VS Code**
1. Abre Visual Studio Code
2. Presiona `Ctrl+Shift+X` (Extension Marketplace)
3. Busca e instala cada una:
   - "C# Dev Kit"
   - "GitHub Copilot"
   - "GitHub Copilot Chat"

**Opción B: Desde Terminal**
```powershell
code --install-extension ms-dotnettools.csharp
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
```

### Paso 3: Configurar GitHub Copilot (10 min)

1. Abre VS Code después de instalar las extensiones
2. Presiona `Ctrl+Shift+P` (Command Palette)
3. Escribe: `GitHub Copilot: Sign in`
4. Sigue el flujo de autenticación
5. Autoriza cuando se te pida
6. Prueba: Presiona `Ctrl+I` para abrir asistente

### Paso 4: Verificar Acceso al Laboratorio (5 min)

```powershell
# Navega a la carpeta del proyecto
cd C:\BN\Proyectos\CopilotAdventures\ContosoDashboard-SSD

# Abre en VS Code
code .

# La aplicación sigue ejecutándose en http://localhost:5000
```

---

## 📚 Estructura del Laboratorio

```
C:\BN\Proyectos\CopilotAdventures\
├── ContosoDashboard-SSD/           # Proyecto principal
│   ├── ContosoDashboard/           # Aplicación ASP.NET Core
│   │   ├── Pages/                  # Páginas Blazor
│   │   ├── Services/               # Servicios de negocio
│   │   ├── Models/                 # Modelos de datos
│   │   ├── Data/                   # DbContext
│   │   └── Program.cs              # Configuración
│   ├── StakeholderDocs/            # Especificaciones
│   ├── README.md                   # Documentación del proyecto
│   ├── ENVIRONMENT_SETUP.md        # Este archivo
│   └── PROJECT_ANALYSIS.md         # Análisis de arquitectura
└── echo-chamber/                   # Proyecto anterior (Echo Chamber v2.0)
```

---

## 🎓 Recursos del Laboratorio

### Documentación del Proyecto
- **PROJECT_ANALYSIS.md** - Análisis completo de arquitectura
- **StakeholderDocs/** - Especificaciones de requisitos (SDD)
- **README.md** - Información general del proyecto

### Conceptos de Spec-Driven Development (SDD)
- Uso de especificaciones como guía de desarrollo
- GitHub Copilot como asistente para implementación
- Tests impulsados por especificaciones

### GitHub Copilot Features para el Laboratorio
- **Inline Suggestions** (`Ctrl+I`) - Sugerencias de código
- **Copilot Chat** (`Ctrl+Shift+I`) - Chat interactivo
- **Code Completion** - Autocompletado inteligente
- **Refactoring** - Sugerencias de mejora

---

## ✨ Características Instaladas

### Entorno de Desarrollo
✅ Git - Control de versiones  
✅ .NET SDK 9.0 - Framework de desarrollo  
✅ Python 3.13 - Scripting y automatización  
✅ UV - Gestor de paquetes Python  
✅ SQL Server LocalDB - Base de datos local  

### Entorno de Código
⏳ Visual Studio Code - Editor  
⏳ C# Dev Kit - Soporte para C#  
⏳ GitHub Copilot - Asistente de IA  
⏳ GitHub Copilot Chat - Chat interactivo  

### Aplicación
✅ ContosoDashboard - Aplicación ASP.NET Core Blazor  
✅ Base de datos - Inicializada y poblada  
✅ Usuario mock - Sistema de autenticación  
✅ Datos de prueba - 4 usuarios, 1 proyecto, 3 tareas  

---

## 🚀 Cómo Comenzar el Laboratorio

### 1. Abre la Aplicación (Está Ejecutándose)
```
http://localhost:5000
```

### 2. Selecciona Usuario de Prueba
```
- admin@contoso.com (Administrador)
- O cualquiera de los otros usuarios
```

### 3. Explora la Interfaz
- Dashboard
- Proyectos
- Tareas
- Equipo
- Notificaciones
- Perfil

### 4. Abre VS Code con el Proyecto
```powershell
cd C:\BN\Proyectos\CopilotAdventures\ContosoDashboard-SSD
code .
```

### 5. Usa GitHub Copilot
- Presiona `Ctrl+I` para sugerencias inline
- Presiona `Ctrl+Shift+I` para chat
- Usa Copilot para implementar nuevas features

### 6. Consulta las Especificaciones
- Lee StakeholderDocs/
- Implementa basado en especificaciones
- Verifica con tests

---

## 🔍 Verificación Final

### Checklist Completo

- [x] Git 2.49.1 instalado
- [x] .NET SDK 9.0.301 instalado
- [x] Python 3.13.3 instalado
- [x] SQL Server LocalDB funcional
- [x] UV 0.9.27 instalado
- [x] Entorno Python configurado
- [x] Aplicación compilada
- [x] Base de datos creada
- [x] Aplicación ejecutable
- [ ] VS Code instalado
- [ ] C# Dev Kit instalado
- [ ] GitHub Copilot instalado
- [ ] GitHub Copilot Chat instalado
- [ ] GitHub Copilot autenticado

---

## 📞 Troubleshooting

### Si la aplicación no se ejecuta
```powershell
cd C:\BN\Proyectos\CopilotAdventures\ContosoDashboard-SSD\ContosoDashboard
dotnet clean
dotnet restore
dotnet build
dotnet run
```

### Si VS Code no abre las extensiones
1. Reinicia VS Code completamente
2. Verifica conexión a internet
3. Actualiza VS Code a la última versión
4. Prueba instalar extensiones desde UI directamente

### Si GitHub Copilot no funciona
1. Verifica que GitHub Copilot esté suscrito
2. Vuelve a autenticar: `GitHub Copilot: Sign in`
3. Reinicia VS Code
4. Verifica que las extensiones estén habilitadas

---

## 📊 Resumen del Estado

| Componente | Status | Acción |
|-----------|--------|--------|
| **Git** | ✅ Listo | - |
| **.NET SDK** | ✅ Listo | - |
| **Python** | ✅ Listo | - |
| **SQL Server** | ✅ Listo | - |
| **UV Manager** | ✅ Listo | - |
| **Aplicación** | ✅ Ejecutándose | - |
| **VS Code** | ⏳ Pendiente | Instalar |
| **Extensiones** | ⏳ Pendiente | Instalar en VS Code |
| **GitHub Auth** | ⏳ Pendiente | Autenticar en VS Code |

---

## 🎊 ¡Listo para Comenzar!

Tu laboratorio GitHub Spec Kit está **completamente configurado** y **listo para usar**.

### Próximas Acciones:
1. ✅ Instala Visual Studio Code
2. ✅ Instala las 3 extensiones (C# Dev Kit, GitHub Copilot, Copilot Chat)
3. ✅ Autentica con GitHub
4. ✅ Abre el proyecto en VS Code
5. ✅ ¡Comienza con Spec-Driven Development!

---

**Laboratorio configurado:** 28 de enero de 2026  
**Versión:** 1.0  
**Estado:** 🟢 OPERACIONAL
