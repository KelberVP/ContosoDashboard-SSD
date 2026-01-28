<!-- 
=============== SYNC IMPACT REPORT ===============
Version Change: N/A → 1.0.0 (Initial Ratification)
Language: Spanish (Español)

Modified Principles: None (Initial Creation)
Added Sections:
- Stack Tecnológico Obligatorio
- Flujo de Desarrollo  
- Seguridad y Protecciones
- Versionado y Cambios
- Gobernanza

Removed Sections: None

Templates Status:
- .specify/templates/spec-template.md        ✅ Compatible (no changes needed)
- .specify/templates/plan-template.md        ✅ Compatible (Constitution Check section references constitution)
- .specify/templates/tasks-template.md       ✅ Compatible (no changes needed)
- .specify/templates/checklist-template.md   ✅ Compatible (no changes needed)
- .github/agents/*.agent.md                  ✅ All compatible

Dependent Files to Review:
- README.md - Reference constitution principles for context
- ARCHITECTURE_GUIDE.md - Align with layered architecture principle
- SETUP.md / ENVIRONMENT_SETUP.md - Document stack requirements

TODO Items: None - All placeholders filled

Ratified: 2026-01-28
===============================================
-->

# Constitución del Proyecto Contoso Dashboard

## Principios Fundamentales

### I. Arquitectura en Capas (Non-Negotiable)
La aplicación DEBE mantener separación clara entre capas: Presentación (Blazor), Servicios (Lógica de Negocio),
Datos (Entity Framework). Cada capa tiene responsabilidades definidas:
- **Presentación**: Solo interfaz de usuario y binding de datos
- **Servicios**: Lógica de negocio, autorización, validaciones
- **Datos**: Acceso a base de datos mediante EF Core, contexto centralizado

Esta separación garantiza testabilidad, mantenibilidad y reutilización de código.

### II. Seguridad Defensiva en Profundidad (Non-Negotiable)
Cada solicitud DEBE validarse en múltiples niveles: middleware, atributos de página, y servicios.
- Protección IDOR obligatoria: verificar autorización antes de acceder a datos
- Claims-based identity con roles RBAC
- Validación de autorización en servicios (no confiar solo en atributos `[Authorize]`)
- Ningún usuario puede acceder a datos de otros usuarios sin autorización explícita

### III. Separación de Responsabilidades mediante Inyección de Dependencias
Todos los servicios DEBEN usar interfaces segregadas e inyección de dependencias en constructores.
- Un servicio = una interfaz pública clara
- Las dependencias se inyectan, no se instancian directamente
- Facilita testing, mocking y evolución hacia servicios en la nube

### IV. Desarrollo Centrado en Especificaciones (SDD - Spec-Driven Development)
TODO desarrollo DEBE seguir el flujo: Especificación → Tests → Implementación → Validación.
- Specs documentan el comportamiento esperado antes de codificar
- Los tests validan que el código cumple la spec
- Propósito educativo: enseñar SDD con GitHub Copilot

### V. Diseño sin Dependencias Externas (Offline-First)
La aplicación DEBE funcionar completamente sin conexión a servicios externos para maximizar disponibilidad en training.
- Base de datos local (SQL Server LocalDB)
- Autenticación mock (sin Azure AD, OAuth)
- Sin integración con servicios en la nube en la rama main
- Arquitectura preparada para migración futura a Azure (layers abstraídas)

## Stack Tecnológico Obligatorio

- **Framework**: ASP.NET Core 9.0 (actual)
- **UI**: Blazor Server + Razor Components
- **ORM**: Entity Framework Core 9.0
- **Base de Datos**: SQL Server LocalDB (desarrollo), SQL Server (producción si aplica)
- **Autenticación**: Cookie-based mock con claims (training), preparado para Azure AD
- **Estilo**: Bootstrap 5.3 con Bootstrap Icons
- **Control de Versiones**: Git + GitHub con flujo de PR

Cualquier adición o cambio en el stack DEBE ser justificado y documentado.

## Flujo de Desarrollo

### 1. Especificación (`.specify/` templates)
- Crear spec antes de implementar (use `/speckit.specify`)
- Spec DEBE incluir: objetivo, funcionalidad, casos de uso, criterios de aceptación
- Especificación aprobada por el equipo antes de pasar a desarrollo

### 2. Pruebas (TDD)
- Tests escritos ANTES de la implementación
- Coverage mínimo del 80% en lógica de servicios
- Tests de integración para flujos usuario → servicio → BD

### 3. Implementación
- Código limpio, bien comentado, siguiendo patrones C#/.NET
- Respeta las capas (no mezclar lógica de UI con servicios)
- Null safety obligatoria (use null-coalescing, null-conditional operators)

### 4. Validación
- Compilación sin errores (warnings revisar caso a caso)
- Todos los tests pasan
- Code review con GitHub Copilot y equipo

## Seguridad y Protecciones

### Autenticación
- Mock system basado en cookies (8 horas sliding expiration en training)
- Claims-based identity con roles (Administrator, Project Manager, Team Lead, Employee)
- Sistema preparado para migrar a Azure AD / Entra ID

### Autorización (RBAC + IDOR)
- Todos los endpoints/servicios DEBEN verificar autorización
- Servicios verifican que el usuario requester tiene acceso al recurso solicitado
- No asumir que `[Authorize]` es suficiente; validar a nivel de servicio

### Datos Sensibles
- Información de usuarios (tareas, proyectos, notificaciones) es privada por defecto
- Cada usuario solo ve sus datos y datos compartidos explícitamente
- Logs NO contienen datos sensibles

## Versionado y Cambios

- **Versión Semántica**: MAJOR.MINOR.PATCH
  - MAJOR: Cambios incompatibles (breaking changes en capas/servicios)
  - MINOR: Nueva funcionalidad que no rompe compatibilidad
  - PATCH: Bugfixes y mejoras menores
- **Breaking changes**: DEBEN documentarse con plan de migración
- **Deprecation**: Función antigua se marca, documentar 2 versiones antes de remover

## Gobernanza

### Cumplimiento
- Esta Constitución SUPERSEDE todas las otras guías de desarrollo
- Toda PR DEBE verificarse contra estos principios
- Violaciones son bloqueantes hasta ser resueltas

### Enmiendas
- Cambios a la Constitución DEBEN justificarse por escrito
- Requerir revisión del equipo principal antes de ratificarse
- Documentar razón de cambio, versión anterior, y fecha en el histórico

### Auditoría
- Reviews de código verifican adherencia a principios
- Tests y compilación son gates obligatorios antes de merge
- Documentación de decisiones arquitectónicas en ADRs (Architecture Decision Records)

**Versión**: 1.0.0 | **Ratificada**: 2026-01-28 | **Última enmienda**: 2026-01-28
