# ContosoDashboard - Análisis de la Estructura del Proyecto

## 📊 Vista General

**Tipo:** Aplicación ASP.NET Core Blazor Server  
**Propósito:** Dashboard educativo para Spec-Driven Development (SDD)  
**Stack:** C#, ASP.NET Core, Blazor Server, Entity Framework Core, SQL Server  
**Autenticación:** Mock Cookie-based (sin dependencias externas)

---

## 📁 Estructura del Proyecto

```
ContosoDashboard/
├── Pages/                          # Páginas Blazor & Razor
│   ├── Index.razor                 # Dashboard principal
│   ├── Projects.razor              # Página de proyectos
│   ├── ProjectDetails.razor        # Detalles de proyecto
│   ├── Tasks.razor                 # Página de tareas
│   ├── Team.razor                  # Página del equipo
│   ├── Notifications.razor         # Notificaciones
│   ├── Profile.razor               # Perfil del usuario
│   ├── Login.cshtml.cs             # Login (Razor Pages)
│   ├── Logout.cshtml.cs            # Logout (Razor Pages)
│   ├── _Imports.razor              # Imports compartidos
│   └── _Host.cshtml                # Layout principal
│
├── Shared/                         # Componentes compartidos
│   ├── MainLayout.razor            # Layout principal
│   ├── NavMenu.razor               # Menú de navegación
│   ├── RedirectToLogin.razor       # Componente de redirección
│   └── _Imports.razor              # Imports para componentes
│
├── Services/                       # Servicios de negocio (inyección de dependencias)
│   ├── UserService.cs              # Gestión de usuarios
│   ├── ProjectService.cs           # Gestión de proyectos
│   ├── TaskService.cs              # Gestión de tareas
│   ├── NotificationService.cs      # Gestión de notificaciones
│   ├── DashboardService.cs         # Servicios del dashboard
│   └── CustomAuthenticationStateProvider.cs  # Autenticación personalizada
│
├── Models/                         # Modelos de datos
│   ├── User.cs                     # Modelo de usuario
│   ├── Project.cs                  # Modelo de proyecto
│   ├── TaskItem.cs                 # Modelo de tarea
│   ├── TaskComment.cs              # Modelo de comentario
│   ├── ProjectMember.cs            # Modelo de miembro de proyecto
│   ├── Notification.cs             # Modelo de notificación
│   └── Announcement.cs             # Modelo de anuncio
│
├── Data/                           # Contexto de base de datos
│   └── ApplicationDbContext.cs     # DbContext de Entity Framework
│
├── Properties/                     # Propiedades y configuración
│   └── launchSettings.json         # Configuración de ejecución
│
├── wwwroot/                        # Recursos estáticos
│   ├── css/                        # Estilos CSS
│   ├── js/                         # Scripts JavaScript
│   └── images/                     # Imágenes
│
├── App.razor                       # Componente raíz
├── Program.cs                      # Configuración de la aplicación
├── appsettings.json               # Configuración general
├── appsettings.Development.json   # Configuración de desarrollo
└── ContosoDashboard.csproj        # Archivo del proyecto
```

---

## 🏗️ Arquitectura

### Capas de la Aplicación

```
┌─────────────────────────────────────────────────────────┐
│           Presentación (Blazor Components)              │
│  Index.razor, Projects.razor, Tasks.razor, etc.        │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│             Servicios de Negocio (Services)             │
│  UserService, ProjectService, TaskService, etc.        │
└────────────────────┬────────────────────────────────────┘
                     │
┌────────────────────▼────────────────────────────────────┐
│          Acceso a Datos (Entity Framework)              │
│        ApplicationDbContext (SQL Server)                 │
└─────────────────────────────────────────────────────────┘
```

### Flujo de Autenticación

```
Usuario accede a la app
        ↓
¿Autenticado? (Cookie)
        │
    No  │  Sí
        ↓   ↓
    Login  Dashboard
    ↓      ↓
Selecciona usuario  Carga datos según rol
    ↓               ↓
Autentica       CustomAuthenticationStateProvider
(Mock)          ↓
    ↓           Blazor autoriza acceso
    └──────────→ Muestra componentes
```

---

## 🔐 Sistema de Seguridad

### Componentes de Seguridad

1. **CustomAuthenticationStateProvider**
   - Proporciona información de autenticación a Blazor
   - Lee claims del usuario autenticado
   - Integra autenticación cookie con Blazor

2. **Middleware de Autenticación**
   - Cookie-based authentication
   - Sliding expiration (8 horas)
   - Login/Logout handlers

3. **Autorización basada en Roles**
   - 4 roles: Employee, TeamLead, ProjectManager, Administrator
   - Políticas de autorización configuradas
   - Atributo `[Authorize]` en componentes

4. **IDOR Protection**
   - Validación de acceso a nivel de servicio
   - Cada usuario ve solo sus datos autorizados

---

## 📦 Modelos de Datos

### Relaciones

```
User (1) ──────┬───── (N) Project (como creador)
               │
               ├───── (N) ProjectMember
               │
               ├───── (N) TaskItem (asignadas)
               │
               ├───── (N) Notification
               │
               └───── (N) TaskComment

Project (1) ───┬───── (N) ProjectMember
               │
               ├───── (N) TaskItem
               │
               └───── (N) Announcement

TaskItem (1) ──┬───── (N) TaskComment
               │
               └───── (1) User (asignado)

ProjectMember (N:N) ← Tabla intermedia entre User y Project
```

### Modelos Principales

| Modelo | Descripción | Campos Clave |
|--------|-------------|--------------|
| **User** | Usuario del sistema | Id, Email, Name, Role, Department |
| **Project** | Proyecto | Id, Name, Description, CreatedBy, Status |
| **TaskItem** | Tarea dentro de proyecto | Id, Title, Description, AssignedTo, Status, Priority |
| **ProjectMember** | Miembro de proyecto | UserId, ProjectId, Role |
| **Notification** | Notificación de usuario | Id, UserId, Message, IsRead |
| **TaskComment** | Comentario en tarea | Id, TaskItemId, AuthorId, Content |
| **Announcement** | Anuncio de proyecto | Id, ProjectId, Title, Content |

---

## 🧩 Servicios Implementados

### IUserService
```csharp
GetAllUsersAsync()
GetUserByIdAsync(userId)
GetCurrentUserAsync(claims)
UpdateUserAsync(user)
```

### IProjectService
```csharp
GetUserProjectsAsync(userId)
GetProjectDetailsAsync(projectId, userId)
CreateProjectAsync(project, userId)
UpdateProjectAsync(project)
DeleteProjectAsync(projectId)
GetProjectMembersAsync(projectId)
```

### ITaskService
```csharp
GetProjectTasksAsync(projectId)
GetTaskDetailAsync(taskId)
CreateTaskAsync(task)
UpdateTaskAsync(task)
CompleteTaskAsync(taskId)
GetTaskCommentsAsync(taskId)
AddCommentAsync(comment)
```

### INotificationService
```csharp
GetUserNotificationsAsync(userId)
MarkNotificationAsReadAsync(notificationId)
CreateNotificationAsync(notification)
DeleteNotificationAsync(notificationId)
```

### IDashboardService
```csharp
GetDashboardDataAsync(userId)
GetProjectsCountAsync(userId)
GetTasksCountAsync(userId)
GetNotificationCountAsync(userId)
```

---

## 📄 Páginas Principales

### Index.razor (Dashboard)
- Vista principal después del login
- Resumen de proyectos
- Tareas asignadas al usuario
- Notificaciones recientes
- Estadísticas generales

### Projects.razor
- Listado de proyectos
- Creación de nuevo proyecto
- Filtros y búsqueda
- Acceso a detalles

### ProjectDetails.razor
- Información completa del proyecto
- Miembros del proyecto
- Tareas del proyecto
- Anuncios del proyecto

### Tasks.razor
- Listado de todas las tareas
- Filtrado por estado/prioridad
- Asignación de tareas
- Actualización de estado

### Team.razor
- Listado de miembros del equipo
- Información de usuario
- Roles y departamentos

### Notifications.razor
- Notificaciones del usuario
- Marcar como leído
- Filtrar por tipo

### Profile.razor
- Perfil del usuario actual
- Información personal
- Edición de datos

### Login.cshtml.cs (Razor Pages)
- Mock login sin contraseña
- Selección de usuario desde dropdown
- Creación de claims basado en rol

---

## 🔄 Flujo de Datos

### Flujo de una Solicitud Típica

```
1. Usuario interactúa con componente Blazor
   ↓
2. Componente llama a un servicio
   ↓
3. Servicio valida autenticación/autorización
   ↓
4. Servicio consulta la base de datos (DbContext)
   ↓
5. DbContext ejecuta consulta SQL Server
   ↓
6. Retorna datos al servicio
   ↓
7. Servicio retorna datos al componente
   ↓
8. Componente actualiza UI (renderizado)
```

---

## 🗄️ Base de Datos

**Motor:** SQL Server  
**Configuración:** Entity Framework Core  
**Conexión:** DefaultConnection (appsettings.json)

### Tablas

- Users
- Projects
- ProjectMembers
- TaskItems
- TaskComments
- Notifications
- Announcements

### Migraciones

Las migraciones se encuentran en el proyecto (EF Core Code First).

---

## 🚀 Configuración de Inicio

### Program.cs - Servicios Registrados

```csharp
// Autenticación y Autorización
AddAuthentication(CookieAuthenticationDefaults)
AddAuthorization(políticas de roles)

// Servicios de aplicación
AddScoped<IUserService, UserService>()
AddScoped<IProjectService, ProjectService>()
AddScoped<ITaskService, TaskService>()
AddScoped<INotificationService, NotificationService>()
AddScoped<IDashboardService, DashboardService>()

// Base de datos
AddDbContext<ApplicationDbContext>()

// Blazor
AddServerSideBlazor()

// Utilidades
AddHttpContextAccessor()
```

---

## 🎯 Usuarios Disponibles para Login

| Email | Rol | Departamento | Permisos |
|-------|-----|--------------|----------|
| admin@contoso.com | Administrator | IT | Acceso total |
| camille.nicole@contoso.com | Project Manager | Engineering | Gestión de proyectos |
| floris.kregel@contoso.com | Team Lead | Engineering | Liderazgo de equipo |
| ni.kang@contoso.com | Employee | Engineering | Acceso básico |

---

## 📋 Características Principales

✅ **Gestión de Proyectos** - Crear, editar, ver proyectos  
✅ **Gestión de Tareas** - Asignar, completar, comentar tareas  
✅ **Gestión de Usuarios** - Perfiles, roles, departamentos  
✅ **Notificaciones** - Sistema de alertas para usuarios  
✅ **Autorización** - Control de acceso basado en roles  
✅ **Mock Authentication** - Login sin necesidad de contraseña  
✅ **Responsivo** - Interfaz adaptable a distintos tamaños  
✅ **Real-time** - Actualizaciones en tiempo real con Blazor Server  

---

## 🛠️ Tecnologías

- **Runtime:** .NET 7/8
- **UI Framework:** Blazor Server
- **Base de Datos:** Entity Framework Core + SQL Server
- **Autenticación:** ASP.NET Core Authentication
- **CSS Framework:** (Bootstrap / CSS personalizado)
- **Tooling:** Visual Studio / VS Code

---

## 📝 Propósito Educativo

Este proyecto está diseñado para enseñar:
- Spec-Driven Development (SDD)
- Arquitectura de capas
- Inyección de dependencias
- Seguridad en ASP.NET Core
- Autorización basada en roles
- Entity Framework Core
- Blazor Server
- Patrones de diseño

⚠️ **Nota:** NO está destinado para producción. Requiere mejoras en seguridad, performance y escalabilidad.

---

## 🚦 Próximos Pasos

1. **Ejecutar la aplicación**
2. **Explorar el código** con VS Code
3. **Estudiar las especificaciones** (StakeholderDocs)
4. **Implementar cambios** según SDD

---

**Análisis generado:** Enero 28, 2026  
**Estado:** Lista para exploración y estudio
