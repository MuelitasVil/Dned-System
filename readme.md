# DNED System

Monorepositorio que centraliza los componentes del sistema de administración de usuarios y licencias de Google y Microsoft de la DNED. Reúne el frontend y dos servicios backend para facilitar la gestión, integración y despliegue del sistema.

---

## 📂 Estructura del repositorio

```text
Dned-System/
├── system/
│   ├── BackEnd-DNED-Organization/
│   ├── Front-Dned/
│   └── BackEnd-DNED-GAM/
├── Tools/
└── README.md
```

Los componentes se incorporan al repositorio mediante Git subtree. Cada módulo conserva su repositorio de origen y puede actualizarse de forma independiente.

## 🧩 Módulos

### 1. DNED Backend (`BackEnd-DNED-Organization`)

**Tecnologías:** FastAPI y MySQL.

API principal que proporciona los servicios de lógica de negocio y persistencia de datos para el sistema de administración. Su arquitectura basada en capas facilita la organización, el mantenimiento y la evolución del código.

### 2. Front-Dned

Aplicación de interfaz de usuario que permite a los operadores interactuar con las funcionalidades de administración de usuarios y licencias de Google y Microsoft.

### 3. GAM Backend (`BackEnd-DNED-GAM`)

**Tecnologías:** FastAPI y MySQL.

Servicio backend especializado en la integración y gestión de Google Apps Manager (GAM), como parte de la arquitectura modular del sistema.

## ⚙️ Requisitos previos

- Git con soporte para `git subtree`.
- Acceso a los repositorios correspondientes en GitHub.
- Una llave SSH configurada y autorizada en GitHub, si se utilizan conexiones SSH.

## 🔄 Actualización de módulos

Desde la raíz del monorepositorio, ejecuta los comandos correspondientes:

```bash
# Actualizar local el backend principal
git subtree pull --prefix=system/BackEnd-DNED-Organization git@github.com:MuelitasVil/BackEnd-DNED-Organization.git main --squash

# Actualizar el frontend
git subtree pull --prefix=system/Front-Dned git@github.com:MuelitasVil/Front-Dned.git main --squash

# Actualizar el backend de GAM
git subtree pull --prefix=system/BackEnd-DNED-GAM git@github.com:MuelitasVil/BackEnd-DNED-GAM.git main --squash
```

```bash
# Actualizar el backend principal
git subtree push --prefix=system/BackEnd-DNED-GAM git@github.com:MuelitasVil/BackEnd-DNED-GAM.git main

# Actualizar el frontend
git subtree push --prefix=system/BackEnd-DNED-GAM git@github.com:MuelitasVil/BackEnd-DNED-GAM.git main

# Actualizar el backend de GAM
git subtree push --prefix=system/BackEnd-DNED-GAM git@github.com:MuelitasVil/BackEnd-DNED-GAM.git main
```


Verifica que la rama principal de cada repositorio sea `main`. Si alguno utiliza `master`, ajusta el comando correspondiente.

Luego, publica los cambios del monorepositorio:

```bash
git push origin main
```

## 🚀 Despliegue

La configuración de despliegue y el archivo `docker-compose` se agregarán cuando se definan los puertos, las variables de entorno y los comandos de inicio de cada módulo.
