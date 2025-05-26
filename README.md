# Informe de Desarrollo — Aplicación Flutter Pokémon

## ✨ Diseño de la solución

El diseño se dividió en tres capas principales:

- **UI** (User Interface): Widgets personalizados, splash screen, botones estilizados, fondo temático y componentes visuales reutilizables como `pokemon_card.dart`.
- **Lógica de negocio**: Uso de `flutter_bloc` para manejar estados de carga, error y éxito durante la obtención de datos desde un servicio HTTP.
- **Datos**: Un `pokemon_service_http.dart` que abstrae la comunicación con una API externa para obtener los datos de los Pokémon.

Para mantener consistencia visual y facilitar la evolución del diseño, se centralizó la paleta de colores en una clase `PokemonColors`, lo que permitió reutilizar estilos desde un solo lugar. El ícono de Pokébola también fue aislado como widget reutilizable para promover la modularidad del código.

---

## 🛠️ Herramientas utilizadas

- **Flutter SDK 3.7.2**
- **Neovim** como editor principal (elección personal por su velocidad y personalización)
- **Bloc / flutter_bloc** para manejo de estados
- **Equatable** para comparar objetos en los estados y eventos de forma eficiente
- **HTTP** para consumir datos de la API
- **Terminal** para ejecución y depuración
- **Git** para control de versiones

La elección de Neovim por sobre editores gráficos como Visual Studio Code representó un enfoque más minimalista y centrado en la productividad, utilizando plugins para autocompletado, resaltado de sintaxis, y control de errores.

---

## 📄 Problemas encontrados y partes más complejas

### 🔍 Problemas encontrados

1. **Problemas de conectividad con pub.dev**: Ocurrieron errores al intentar descargar paquetes desde el servidor de paquetes de Dart (`SocketException` por timeout). Se resolvió limpiando el caché del sistema Flutter.
2. **Gestión del progreso real en la pantalla de carga**: Mostrar una barra de carga que refleje verdaderamente el avance de las tareas (por ejemplo, obtener imágenes, preparar el listado) fue un reto. Se solucionó dividiendo la carga en pasos concretos y actualizando el estado del `SplashBloc` en consecuencia.
3. **Separación de responsabilidades visuales**: Para mantener el código limpio, fue necesario refactorizar componentes como el ícono de Pokébola y los colores. Esto requirió identificar patrones repetitivos y extraer widgets reutilizables.

### ⚙️ Partes más difíciles

- **Integración del Splash con animación realista**: Coordinar la animación de carga con los eventos de BLoC fue una de las partes más técnicas del proyecto. Evitar que la vista avance antes de que el progreso llegue al 99% exigió una lógica cuidadosa en la transición de estados.
- **Diseño responsivo en Web y Móvil**: Aunque Flutter permite desplegar en múltiples plataformas, ajustar márgenes, escalas y fuentes para que se vieran bien en todas las resoluciones fue desafiante, sobre todo desde Neovim sin vistas previas inmediatas como en VS Code.
- **Refactorización de colores y estilos**: Lograr una paleta coherente que evocara el universo Pokémon pero que no recargara la vista fue un trabajo iterativo que involucró pruebas visuales y ajustes progresivos en `PokemonColors`.

---

## ✅ Conclusiones

El uso de Flutter con BLoC resultó adecuado para el tipo de aplicación, permitiendo separar la lógica del UI de manera efectiva. El uso de Neovim, aunque menos común en entornos Flutter, no representó una desventaja técnica, y permitió mayor control y personalización del flujo de trabajo.

El mayor aprendizaje fue cómo mantener la estructura modular del código sin sacrificar legibilidad ni escalabilidad, y cómo resolver errores en tiempo real bajo un entorno controlado por terminal.

