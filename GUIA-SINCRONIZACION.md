# FixTecno Sur — configurar el historial compartido

La sincronización todavía no está activa: hay que crear un proyecto y configurar cada dispositivo. Hasta entonces el historial funciona solo en el dispositivo en que se guarda. La app web necesita estar alojada en HTTPS o instalarse en un origen seguro; el APK ya utiliza un origen seguro. Acceso a internet necesario para iniciar sesión y sincronizar.

## Preparación de Supabase

1. Crea una cuenta en https://supabase.com y un proyecto nuevo. Revisa el plan, sus límites de almacenamiento y su política de inactividad antes de usarlo para datos importantes. Una ficha puede incluir fotos y consumir bastante espacio.
2. En **SQL Editor**, abre y ejecuta una vez el archivo `supabase-setup.sql` que acompaña a esta guía. La tabla contiene los presupuestos y sus fotografías; las políticas limitan las fichas al usuario autenticado que las creó.
3. En **Authentication → Users**, crea un usuario con correo y contraseña para compartir entre los dispositivos del taller. Activa o confirma el correo según las opciones del panel. Desactiva el registro público de nuevos usuarios en la configuración de autenticación si no lo necesitas. Usa una contraseña fuerte y entrégala solo a personas autorizadas. Todos los que utilicen esa cuenta verán los mismos presupuestos y no habrá identificación individual de quién editó.
4. En **Project Settings → API** (o Connect / API Keys según la interfaz), copia la **Project URL** y la clave pública **publishable** o **anon**. **Nunca uses ni compartas la clave `service_role`, una clave secreta `sb_secret_`, la contraseña de base de datos o la contraseña de la cuenta con soporte.** La clave pública no reemplaza las políticas de seguridad.
5. En la app, abre **Historial de presupuestos → Configurar conexión** y guarda la URL y la clave pública. En **Iniciar sesión**, ingresa el correo y la contraseña de la cuenta compartida. Autoriza vincular los presupuestos locales si deseas subirlos a esta cuenta.
6. Repite el paso 5 en el APK y en cada navegador/dispositivo. Pulsa **Sincronizar ahora** si quieres comprobar que las fichas aparecen en ambos. La sincronización también se intenta al guardar, al iniciar la aplicación, al recuperar conexión y periódicamente mientras está abierta.

## Uso y cuidados

- El borrador se guarda automáticamente en el dispositivo, pero **Guardar presupuesto en historial** es lo que crea o actualiza la ficha del historial. Al abrir otra ficha se reemplaza el borrador, por lo que debes guardar primero los cambios que quieras conservar.
- Si no hay internet, la ficha queda guardada localmente y marcada como pendiente. Para sincronizar debe existir una sesión válida en la misma cuenta y proyecto. Una sesión vencida puede requerir volver a iniciar sesión. Si guardaste antes de configurar la cuenta, al iniciar sesión se pregunta si deseas vincular esos presupuestos locales.
- Si dos equipos editan la misma versión, se conserva la versión remota y una **copia por conflicto** con los cambios locales, para revisarlas. Sincroniza de nuevo para subir la copia. No se fusionan automáticamente.
- El historial conserva fotos, datos, conceptos y precios de cada ficha. Los cambios en el **catálogo, marcas/modelos y técnicos son locales**, no se sincronizan. El panel de administración no lleva contraseña.
- Los datos y la sesión quedan almacenados localmente; cerrar sesión no borra las fichas locales. Usa solo equipos de confianza, protege el acceso y mantén respaldos de la base de datos y dispositivos según tus necesidades. Borrar datos del navegador o desinstalar el APK puede borrar el historial local y los cambios pendientes; verifica antes que se hayan sincronizado.
- Para acceso por varios usuarios individuales con permisos diferentes se necesitaría desarrollar un sistema de organizaciones y permisos; esta versión está diseñada para una cuenta compartida.
- La calidad y disponibilidad del servicio externo dependen de Supabase. Una copia en la nube no sustituye un plan de respaldo. Los datos incluyen información personal de clientes: controla accesos y cumple las obligaciones de privacidad aplicables.
