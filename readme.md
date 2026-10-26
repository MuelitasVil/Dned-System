# DNED System

Monorepositorio que centraliza los componentes del sistema de administración de usuarios y licencias de Google y Microsoft de la DNED. Reúne el frontend y dos servicios backend para facilitar la gestión, integración y despliegue del sistema.

---

## 📂 Estructura del Repositorio

```text
Dned-System/
├── system/
│   ├── BackEnd-DNED-Organization/
│   ├── Front-Dned/
│   └── BackEnd-DNED-GAM/
├── Tools/
└── README.md
Los componentes se incorporan al repositorio mediante Git Subtree. Cada módulo conserva su repositorio de origen y puede actualizarse de forma independiente.

🧩 Módulos
1. DNED Backend (BackEnd-DNED-Organization)
Tecnología: FastAPI, MySQL.

Descripción: API principal que proporciona los servicios de lógica de negocio y persistencia para el sistema de administración. Su arquitectura basada en capas facilita la organización, el mantenimiento y la evolución del código.

2. Front-Dned (Front-Dned)
Descripción: Aplicación de interfaz de usuario. Permite a los operadores interactuar de forma intuitiva con las funcionalidades de administración de usuarios y licencias de Google y Microsoft.

3. GAM Backend (BackEnd-DNED-GAM)
Tecnología: FastAPI, MySQL.

Descripción: Servicio backend especializado en la integración y gestión de Google Apps Manager (GAM), operando como parte de la arquitectura modular del sistema.

⚙️ Requisitos Previos
Git con soporte para git subtree.

Acceso a los repositorios correspondientes en GitHub.

Llave SSH configurada y autorizada en GitHub (en caso de utilizar clonación/conexión vía SSH).

🔄 Actualización de Módulos
Para actualizar los submódulos desde la raíz del monorepositorio, ejecuta los siguientes comandos según corresponda:

Bash
# Actualizar el backend principal
git subtree pull --prefix=system/BackEnd-DNED-Organization git@github.com:MuelitasVil/BackEnd-DNED-Organization.git main --squash

# Actualizar el frontend
git subtree pull --prefix=system/Front-Dned git@github.com:MuelitasVil/Front-Dned.git main --squash

# Actualizar el backend de GAM
git subtree pull --prefix=system/BackEnd-DNED-GAM git@github.com:MuelitasVil/BackEnd-DNED-GAM.git main --squash
Nota: Verifica que la rama principal de cada repositorio sea main. Si alguno de ellos utiliza master, ajusta el comando según sea necesario.

Luego, publica los cambios generales en el monorepositorio:

Bash
git push origin main
🚀 Despliegue
La configuración de despliegue y el archivo docker-compose se agregarán próximamente, una vez que se definan los puertos, las variables de entorno y los comandos de inicio de cada módulo.