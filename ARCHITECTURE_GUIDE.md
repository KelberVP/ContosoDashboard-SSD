# ContosoDashboard - Estructura del Proyecto

## 🎯 Visión General

**ContosoDashboard** es una aplicación **ASP.NET Core Blazor Server** diseñada para **Spec-Driven Development (SDD) training** con GitHub Copilot.

### Stack Tecnológico
- **Framework**: ASP.NET Core 8.0 + Blazor Server
- **UI**: Razor Components + Bootstrap
- **ORM**: Entity Framework Core 8.0
- **Base Datos**: SQL Server LocalDB
- **Autenticación**: Mock Cookie-based (con roles)
- **IDE**: Visual Studio Code + GitHub Copilot

---

## 📁 Estructura de Directorios

```
ContosoDashboard/
├── Pages/                    ← Componentes UI (Blazor)
├── Services/                 ← Lógica de negocio
├── Models/                   ← Entidades de datos
├── Data/                     ← DbContext y datos iniciales
├── Shared/                   ← Componentes compartidos
├── wwwroot/                  ← Archivos estáticos
├── Properties/               ← Configuración del proyecto
├── Program.cs                ← Configuración de la app
├── App.razor                 ← Componente raíz
└── appsettings.json         ← Configuración
```

---

## 🏗️ Arquitectura en Capas

### 1. **PRESENTATION LAYER** (Pages/)
Componentes Blazor Server que manejan la interfaz de usuario.

**Páginas principales:**
```
Pages/
├── Index.razor              ← Dashboard principal
├── Projects.razor           ← Gestión de proyectos
├── Tasks.razor              ← Gestión de tareas
├── ProjectDetails.razor     ← Detalles del proyecto
├── Team.razor               ← Gestión del equipo
├── Notifications.razor      ← Notificaciones
├── Profile.razor            ← Perfil de usuario
├── Login.cshtml + .cs       ← Autenticación
├── Logout.cshtml + .cs      ← Cierre de sesión
├── _Host.cshtml             ← Host HTML
└── _Imports.razor           ← Imports compartidos
```

**Características:**
- Componentes interactivos en tiempo real
- Comunicación bidireccional servidor-cliente
- State management con @inject
- Event handling y data binding

---

### 2. **BUSINESS LOGIC LAYER** (Services/)
Servicios que implementan la lógica de negocio.

**Servicios principales:**
```
Services/
├── IProjectService.cs                    ← Gestión de proyectos
├── ProjectService.cs
│
├── ITaskService.cs                       ← Gestión de tareas
├── TaskService.cs
│
├── IUserService.cs                       ← Gestión de usuarios
├── UserService.cs
│
├── INotificationService.cs               ← Notificaciones
├── NotificationService.cs
│
├── IDashboardService.cs                  ← Dashboard
├── DashboardService.cs
│
└── CustomAuthenticationStateProvider.cs ← Autenticación
```

**Patrón de diseño:**
- Interface segregation (IXyzService)
- Dependency injection en constructor
- Async/await para operaciones DB
- Entity Framework queries

**Ejemplo - ProjectService:**
```csharp
public interface IProjectService
{
    Task<List<Project>> GetUserProjectsAsync(int userId);
    Task<Project?> GetProjectByIdAsync(int projectId, int requestingUserId);
    Task<Project> CreateProjectAsync(Project project);
    Task<bool> UpdateProjectAsync(Project project, int requestingUserId);
    Task<bool> AddProjectMemberAsync(int projectId, int userId, string role, int requestingUserId);
}
```

---

### 3. **DATA LAYER** (Data/)
Entity Framework Core context y configuración de datos.

```
Data/
└── ApplicationDbContext.cs
    ├── DbSet<User>              ← Usuarios
    ├── DbSet<Project>           ← Proyectos
    ├── DbSet<TaskItem>          ← Tareas
    ├── DbSet<ProjectMember>     ← Miembros del proyecto
    ├── DbSet<TaskComment>       ← Comentarios de tareas
    ├── DbSet<Notification>      ← Notificaciones
    └── DbSet<Announcement>      ← Anuncios
```

**Relaciones definidas:**
- User ↔ AssignedTasks (1:N)
- User ↔ CreatedTasks (1:N)
- User ↔ ManagedProjects (1:N)
- Project ↔ Tasks (1:N)
- User ↔ ProjectMembers (1:N)
- Indexes para optimización

---

### 4. **MODELS LAYER** (Models/)
Entidades de datos con validación.

**Entidades principales:**

#### **User.cs**
```csharp
public class User
{
    public int UserId { get; set; }
    public string Email { get; set; }
    public string DisplayName { get; set; }
    public UserRole Role { get; set; }  // Employee, TeamLead, ProjectManager, Admin
    public AvailabilityStatus AvailabilityStatus { get; set; }
    
    // Navigation properties
    public ICollection<TaskItem> AssignedTasks { get; set; }
    public ICollection<Project> ManagedProjects { get; set; }
}
```

#### **Project.cs**
```csharp
public class Project
{
    public int ProjectId { get; set; }
    public string ProjectName { get; set; }
    public string Description { get; set; }
    public int ProjectManagerId { get; set; }
    public ProjectStatus Status { get; set; }  // Active, OnHold, Completed
    
    // Navigation properties
    public User ProjectManager { get; set; }
    public ICollection<TaskItem> Tasks { get; set; }
    public ICollection<ProjectMember> ProjectMembers { get; set; }
}
```

#### **TaskItem.cs**
```csharp
public class TaskItem
{
    public int TaskId { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public TaskStatus Status { get; set; }  // NotStarted, InProgress, Completed
    public int ProjectId { get; set; }
    public int? AssignedUserId { get; set; }
    public int CreatedByUserId { get; set; }
    
    // Navigation properties
    public Project Project { get; set; }
    public User AssignedUser { get; set; }
    public User CreatedByUser { get; set; }
}
```

#### **ProjectMember.cs**
```csharp
public class ProjectMember
{
    public int ProjectMemberId { get; set; }
    public int ProjectId { get; set; }
    public int UserId { get; set; }
    public ProjectMemberRole Role { get; set; }  // Member, Lead
    
    // Navigation properties
    public Project Project { get; set; }
    public User User { get; set; }
}
```

**Otros modelos:**
- **Notification.cs** - Notificaciones para usuarios
- **TaskComment.cs** - Comentarios en tareas
- **Announcement.cs** - Anuncios globales

---

## 🔐 Autenticación y Autorización

### Autenticación (Mock - Propósito Educativo)
```csharp
// Program.cs
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/login";
        options.ExpireTimeSpan = TimeSpan.FromHours(8);
        options.SlidingExpiration = true;
    });
```

### Roles Disponibles
```csharp
public enum UserRole
{
    Employee,          // Rol básico
    TeamLead,          // Lidera un equipo
    ProjectManager,    // Gestiona proyectos
    Administrator      // Acceso total
}
```

### Políticas de Autorización
```
Employee:       Pueden ver su propio dashboard
TeamLead:       Acceso a funciones de equipo
ProjectManager: Pueden gestionar proyectos
Administrator:  Acceso a todo
```

### Usuarios de Prueba
```
1. admin@contoso.com              | Admin
2. camille.nicole@contoso.com     | Project Manager
3. floris.kregel@contoso.com      | Team Lead
4. ni.kang@contoso.com            | Employee
```

---

## 🔄 Flujo de Datos

### Ejemplo: Obtener Proyectos del Usuario

```
1. UI (Projects.razor)
   ↓
   @inject IProjectService ProjectService
   ↓
2. Componente llama
   projectList = await ProjectService.GetUserProjectsAsync(userId)
   ↓
3. Service Query
   var projects = _context.Projects
       .Where(p => p.ProjectManagerId == userId || 
                   p.ProjectMembers.Any(pm => pm.UserId == userId))
       .Include(p => p.ProjectManager)
       .Include(p => p.Tasks)
   ↓
4. EF Core genera SQL
   ↓
5. Base de datos devuelve datos
   ↓
6. Service retorna List<Project>
   ↓
7. UI renderiza componentes
```

---

## 🗄️ Esquema de Base de Datos

```sql
-- Tablas principales
Tables:
├── Users                 (Id, Email, DisplayName, Role, AvailabilityStatus, ...)
├── Projects             (Id, Name, Description, ProjectManagerId, Status, ...)
├── Tasks                (Id, Title, Description, Status, ProjectId, AssignedUserId, ...)
├── ProjectMembers       (Id, ProjectId, UserId, Role, ...)
├── TaskComments         (Id, TaskId, UserId, Content, CreatedDate, ...)
├── Notifications        (Id, UserId, Title, Content, IsRead, CreatedDate, ...)
└── Announcements        (Id, Title, Content, CreatedDate, ...)

-- Relaciones
Users ← ProjectMembers → Projects
Users ← Tasks → Projects
Users ← TaskComments → Tasks
Users ← Notifications
```

---

## 🔧 Dependencias Inyectadas

### En Program.cs
```csharp
// Servicios registrados
builder.Services.AddScoped<IProjectService, ProjectService>();
builder.Services.AddScoped<ITaskService, TaskService>();
builder.Services.AddScoped<IUserService, UserService>();
builder.Services.AddScoped<INotificationService, NotificationService>();
builder.Services.AddScoped<IDashboardService, DashboardService>();
builder.Services.AddScoped<AuthenticationStateProvider, CustomAuthenticationStateProvider>();
builder.Services.AddDbContext<ApplicationDbContext>();
```

### Inyección en Componentes
```csharp
@page "/projects"
@inject IProjectService ProjectService
@inject IUserService UserService
@implements IAsyncDisposable

// Usar servicios
protected override async Task OnInitializedAsync()
{
    projects = await ProjectService.GetUserProjectsAsync(userId);
}
```

---

## 🚀 Puntos de Entrada

### Para Desarrolladores
1. **UI**: Pages/*.razor (donde comienza la interacción del usuario)
2. **Lógica**: Services/IXyzService.cs (interfaz del servicio)
3. **Datos**: Models/*.cs (definición de entidades)
4. **DB**: Data/ApplicationDbContext.cs (configuración de datos)

### Flujo típico de desarrollo:
```
1. Lee la especificación en StakeholderDocs/
2. Abre el archivo Pages/[Feature].razor
3. Usa Copilot (Ctrl+Shift+I) para generar:
   - Interfaz del servicio (IXyzService)
   - Implementación del servicio (XyzService)
   - Lógica de componente
4. Ejecuta y verifica
```

---

## 📚 Archivo de Configuración Principal

### Program.cs (112 líneas)
- Configuración de servicios
- DbContext
- Autenticación/Autorización
- Policies de acceso
- Startup pipeline

### appsettings.json
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=ContosoDashboard;..."
  },
  "Logging": { ... }
}
```

---

## 🎓 Cómo Usar con GitHub Copilot

### Ejercicio 1: Agregar una Nueva Funcionalidad
```
1. Abre StakeholderDocs/ y lee requisitos
2. Abre Services/[Service].cs
3. Presiona Ctrl+Shift+I
4. Prompt: "Implementa el método [método] según esta interfaz"
5. Copilot genera el código
6. Verifica y ajusta
```

### Ejercicio 2: Crear un Nuevo Componente
```
1. Abre Pages/Index.razor como referencia
2. Crea Pages/[Feature].razor
3. Ctrl+Shift+I: "Crea un componente Blazor para [funcionalidad]"
4. Copilot genera structure, @inject, métodos
```

### Ejercicio 3: Agregar Validación
```
1. Abre Models/[Entity].cs
2. Ctrl+Shift+I: "Agrega validaciones DataAnnotation para [Entity]"
3. Copilot añade [Required], [EmailAddress], etc.
```

---

## ✨ Características Principales

✅ **Dashboard**: Vista consolidada de proyectos y tareas  
✅ **Gestión de Proyectos**: Crear, actualizar, asignar miembros  
✅ **Gestión de Tareas**: CRUD completo con asignaciones  
✅ **Equipo**: Ver y gestionar miembros del equipo  
✅ **Notificaciones**: Sistema de alertas en tiempo real  
✅ **Perfil**: Información y preferencias del usuario  
✅ **Roles**: Sistema de autorización basado en roles  
✅ **Real-time**: Actualizaciones en vivo vía Blazor Server  

---

## 🎯 Próximos Pasos

1. **Explorar el código**: Abre cada archivo .cs
2. **Leer especificaciones**: StakeholderDocs/
3. **Usar Copilot**: Ctrl+Shift+I para generar código
4. **Experimentar**: Modifica y aprende
5. **Implementar**: Sigue los requisitos de SDD

---

**Status**: 🟢 OPERACIONAL  
**Framework**: ASP.NET Core 8.0 + Blazor  
**BD**: ContosoDashboard (SQL Server LocalDB)  
**Servidor**: http://localhost:5000  

¡Listo para aprender Spec-Driven Development! 🚀
