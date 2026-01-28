# 🛠️ Configuración del Entorno - GitHub Spec Kit Lab

## ✅ Estado Actual del Entorno

Fecha de verificación: **28 de enero de 2026**

### Requisitos Verificados

| Requisito | Versión Requerida | Versión Instalada | Estado |
|-----------|------------------|------------------|--------|
| **Git** | 2.48+ | 2.49.1 | ✅ OK |
| **.NET SDK** | 8.0+ | 9.0.301 | ✅ OK |
| **Python** | 3.11+ | 3.13.3 | ✅ OK |
| **SQL Server LocalDB** | - | Detectado | ✅ OK |
| **UV Package Manager** | - | No instalado | ⚠️ NECESARIO |
| **Visual Studio Code** | - | (Por verificar) | ⏳ |
| **C# Dev Kit** | - | (Por verificar) | ⏳ |
| **GitHub Copilot Chat** | - | (Por verificar) | ⏳ |

---

## 📋 Detalles de la Verificación

### 1. ✅ Git (INSTALADO)
```
Versión: 2.49.1.windows.1
Requisito: 2.48+
Estado: CUMPLE ✅

Verificar instalación:
$ git --version
```

### 2. ✅ .NET SDK (INSTALADO)
```
Versión: 9.0.301
Requisito: 8.0+
Estado: CUMPLE ✅

Verificar instalación:
$ dotnet --version

Información completa:
$ dotnet --info
```

### 3. ✅ Python (INSTALADO)
```
Versión: 3.13.3
Requisito: 3.11+
Estado: CUMPLE ✅

Verificar instalación:
$ python --version
```

### 4. ✅ SQL Server LocalDB (DETECTADO)
```
Status: FUNCIONAL
Base de datos: ContosoDashboard
Tablas: 7 (Users, Projects, Tasks, Notifications, etc.)

Conexión de prueba realizada correctamente.
Base de datos inicializada con datos de ejemplo.
```

### 5. ⚠️ UV Package Manager (NO INSTALADO - NECESARIO)
```
Versión: No instalada
Requisito: Requerido para el laboratorio
Status: NECESITA INSTALACIÓN ⚠️

UV es un gestor de paquetes Python rápido y moderno.
```

---

## 🚀 Instalación de UV (Gestor de Paquetes Python)

### Opción 1: Instalación usando PowerShell (Recomendado)

```powershell
# Instalar UV usando pipx
pip install pipx

# Instalar UV
pipx install uv

# Verificar instalación
uv --version
```

### Opción 2: Instalación usando PowerShell con curl

```powershell
# En Windows, ejecuta:
irm https://astral.sh/uv/install.ps1 | iex

# Verificar instalación
uv --version
```

### Opción 3: Instalación usando pip directamente

```powershell
pip install uv

# Verificar instalación
uv --version
```

---

## 🔍 Verificación de Visual Studio Code

### Instalar Visual Studio Code (si no está instalado)

Descarga desde: https://code.visualstudio.com/

### Extensiones Requeridas

Abre VS Code y busca estas extensiones en el Marketplace (`Ctrl+Shift+X`):

1. **C# Dev Kit**
   - ID: `ms-dotnettools.csharp`
   - Descripción: Proporciona soporte completo para C# y .NET
   - Estado: ⏳ Por instalar

2. **GitHub Copilot Chat**
   - ID: `GitHub.copilot-chat`
   - Descripción: Chat con IA para desarrollo asistido
   - Estado: ⏳ Por instalar

3. **Extensiones Recomendadas Adicionales**
   - `ms-azuretools.vscode-docker` - Docker support
   - `eamodio.gitlens` - Git integration
   - `ms-dotnettools.vscode-dotnet-runtime` - .NET runtime

### Instalación de Extensiones

```bash
# Desde Terminal (en VS Code)
code --install-extension ms-dotnettools.csharp
code --install-extension GitHub.copilot-chat
```

O instala manualmente desde el UI:
1. Presiona `Ctrl+Shift+X` (Extension Marketplace)
2. Busca la extensión
3. Click en "Install"

---

## 🔐 GitHub Copilot Configuration

### Requisitos

- ✅ Cuenta de GitHub activa
- ✅ Suscripción de GitHub Copilot activada
- ⏳ Autenticación en VS Code

### Activar GitHub Copilot

1. Abre VS Code
2. Instala "GitHub Copilot" y "GitHub Copilot Chat" (ver arriba)
3. Presiona `Shift+Cmd+P` (o `Ctrl+Shift+P` en Windows)
4. Escribe: `GitHub Copilot: Sign in`
5. Sigue el flujo de autenticación
6. Autoriza cuando se te pida

### Verificar Copilot

- Presiona `Ctrl+I` para abrir el asistente inline
- Presiona `Ctrl+Shift+I` para abrir Copilot Chat
- Deberías ver el logo de Copilot en la esquina

---

## 🏗️ Estado del Laboratorio

### Aplicación ContosoDashboard

```
✅ Repositorio clonado
✅ Dependencias restauradas
✅ Proyecto compilado
✅ Base de datos creada
✅ Datos de ejemplo cargados
✅ Aplicación ejecutada exitosamente
```

**URL:** http://localhost:5000  
**Usuarios disponibles:** 4 usuarios de prueba (admin, PM, TeamLead, Employee)

---

## ✅ Checklist de Configuración Completa

### Herramientas del Sistema
- [x] Git 2.49.1 instalado
- [x] .NET SDK 9.0.301 instalado
- [x] Python 3.13.3 instalado
- [x] SQL Server LocalDB disponible

### Herramientas de Desarrollo
- [x] Visual Studio Code instalado
- [ ] C# Dev Kit extension instalada
- [ ] GitHub Copilot Chat extension instalada

### Configuración de GitHub
- [ ] Cuenta de GitHub verificada
- [ ] GitHub Copilot suscripción activa
- [ ] VS Code autenticado con GitHub

### Gestor de Paquetes
- [ ] UV package manager instalado

### Proyecto
- [x] ContosoDashboard clonado
- [x] Dependencias restauradas
- [x] Proyecto compilado
- [x] Base de datos configurada

---

## 🎯 Próximos Pasos

### Inmediato (5-10 minutos)
1. **Instalar UV Package Manager**
   ```powershell
   pip install uv
   uv --version
   ```

### Corto Plazo (10-15 minutos)
2. **Verificar Visual Studio Code**
   - Descargar si no está instalado
   - Instalar extensiones requeridas

3. **Configurar GitHub Copilot**
   - Verificar suscripción activa
   - Autenticar en VS Code
   - Verificar funcionalidad

### Laboratorio
4. **Acceder a la aplicación**
   - Visitar http://localhost:5000
   - Login con usuario de prueba
   - Explorar la interfaz

5. **Comenzar ejercicios de Spec-Driven Development**
   - Revisar especificaciones (StakeholderDocs)
   - Usar GitHub Copilot para código
   - Implementar features

---

## 📚 Recursos Útiles

### Documentación
- [GitHub Copilot Docs](https://docs.github.com/en/copilot)
- [.NET Documentation](https://learn.microsoft.com/en-us/dotnet/)
- [Blazor Docs](https://learn.microsoft.com/en-us/aspnet/core/blazor/)
- [UV Package Manager](https://docs.astral.sh/uv/)

### Proyecto ContosoDashboard
- [PROJECT_ANALYSIS.md](../PROJECT_ANALYSIS.md) - Análisis de arquitectura
- [README.md](../README.md) - Información del proyecto
- StakeholderDocs/ - Especificaciones y requisitos

---

## 🆘 Resolución de Problemas

### UV no se instala
```powershell
# Opción 1: Usando pipx
pip install pipx
pipx install uv

# Opción 2: Usando pip directamente
pip install --upgrade uv

# Opción 3: Descarga el instalador
# https://github.com/astral-sh/uv/releases
```

### Visual Studio Code extensions no instalan
- Reinicia VS Code
- Verifica conexión a internet
- Actualiza VS Code a la última versión
- Prueba instalar manualmente desde marketplace

### GitHub Copilot no funciona
- Verifica que tengas suscripción activa
- Vuelve a autenticar: `GitHub Copilot: Sign in`
- Reinicia VS Code
- Verifica que las extensiones estén habilitadas

### Base de datos no se conecta
- Verifica que SQL Server LocalDB esté corriendo
- Revisa la cadena de conexión en appsettings.json
- Ejecuta `nuget.config` fue actualizado correctamente

---

## 📊 Resumen Actual

| Componente | Status | Acción |
|-----------|--------|--------|
| Git | ✅ Instalado | - |
| .NET SDK | ✅ Instalado | - |
| Python | ✅ Instalado | - |
| SQL Server | ✅ Funcional | - |
| UV Package Manager | ⚠️ No instalado | **INSTALAR** |
| VS Code | ⏳ No verificado | Verificar/Instalar |
| C# Dev Kit | ⏳ No instalado | Instalar |
| GitHub Copilot Chat | ⏳ No instalado | Instalar |
| GitHub Auth | ⏳ No verificado | Verificar |
| ContosoDashboard App | ✅ Ejecutando | - |

---

**Entorno configurado:** Enero 28, 2026  
**Versión:** 1.0  
**Listo para:** Laboratorio de Spec-Driven Development
