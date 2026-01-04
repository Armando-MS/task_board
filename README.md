# TaskBoard – Aplicación Flutter

TaskBoard es una aplicación móvil desarrollada en Flutter para la gestión de tareas personales.  
La aplicación permite crear, editar, eliminar y filtrar tareas, utilizando el patrón BLoC para el manejo de estado y Hive para la persistencia local de la información.

---

## Descripción general

La aplicación fue desarrollada siguiendo buenas prácticas de arquitectura, separando la lógica de negocio, el manejo de estado y la interfaz gráfica.  
El objetivo principal es demostrar el uso de Flutter junto con un gestor de estado moderno y un sistema de almacenamiento local eficiente.

---

## Funcionalidades

- Crear nuevas tareas con título y descripción.
- Editar tareas existentes.
- Eliminar tareas mediante gesto de deslizamiento.
- Marcar tareas como completadas o pendientes.
- Filtrar tareas por estado:
  - Todas
  - Pendientes
  - Completadas
- Persistencia local de datos (las tareas se mantienen al cerrar la aplicación).
- Manejo de estado centralizado con BLoC.

---

## Indicaciones de uso

- Para **agregar una nueva tarea**, presione el botón con el ícono **“+”** ubicado en la parte inferior de la pantalla principal.
- Al crear una tarea, la aplicación solicitará ingresar un **título** (obligatorio) y una **descripción** corta (opcional).
- Una vez guardada, la tarea se mostrará en la lista principal.
- En la parte superior de la pantalla se encuentra el **filtro de tareas**, que permite visualizar:
  - Todas las tareas
  - Tareas pendientes
  - Tareas finalizadas
- Cada tarea cuenta con un **checkbox**, el cual permite marcarla como **finalizada** o devolverla a estado **pendiente**.
- Al **presionar una tarea**, se abrirá la pantalla de edición, donde se podrán modificar el título y la descripción.
- Para **eliminar una tarea**, deslice la tarea hacia un lado de la pantalla.  
  Al realizar este gesto, se mostrará una animación junto con el ícono de eliminación, y la tarea será removida de la lista.
- Todos los cambios realizados se guardan automáticamente, por lo que las tareas se conservan incluso al cerrar la aplicación.

## Arquitectura del proyecto

El proyecto está organizado por capas para facilitar el mantenimiento y la escalabilidad:

- **models**  
  Contiene las clases que representan las entidades principales de la aplicación (usuario y tareas), incluyendo su configuración para Hive.

- **bloc**  
  Contiene el BLoC, los eventos y los estados que gestionan la lógica de negocio y el flujo de datos de la aplicación.

- **services**  
  Encargados de la persistencia de datos, en este caso, la comunicación con Hive para guardar y recuperar la información del usuario y sus tareas.

- **screens**  
  Pantallas principales de la aplicación, como la pantalla principal y la pantalla para agregar o editar tareas.

- **widgets**  
  Widgets reutilizables, como el filtro de tareas, que permiten mantener una interfaz más limpia y modular.

- **main.dart**  
  Punto de entrada de la aplicación, donde se inicializa Hive, se registran los adapters y se configura el BLoC principal.

---

## Requisitos del sistema

- Flutter SDK (canal estable recomendado)
- Dart SDK
- Android Studio o Visual Studio Code
- Emulador Android o dispositivo físico Android

---

## Instrucciones para ejecutar el proyecto

Siga los siguientes pasos para ejecutar correctamente la aplicación:

### 1. Clonar el repositorio
```bash
git clone <URL_DEL_REPOSITORIO>
cd task_board
```

### 2. Instalar dependencias
```bash
flutter pub get
```

### 3. Generar archivos de Hive
```bash
flutter pub run build_runner build
```

### 4. Limpiar y ejecutar la aplicación
```bash
flutter clean
flutter run
```

## Dependencias principales

- **flutter_bloc**: Manejo de estado basado en el patrón BLoC.
- **hive**: Base de datos local ligera y rápida.
- **hive_flutter**: Integración de Hive con Flutter.
- **hive_generator**: Generación automática de adapters de Hive.
- **build_runner**: Herramienta para generar código automáticamente.

---

## Plataforma soportada

- Android, Navegador Web

---

## Autor

Armando Moreira
