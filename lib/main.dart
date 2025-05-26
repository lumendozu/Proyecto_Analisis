import 'package:flutter/material.dart';

// Vista de inicio que se muestra tras la animación de entrada.
import 'views/init_view.dart';

// Vista que representa el estado de carga del sistema.
import 'views/loading_view.dart';

// Vista que muestra un mensaje de error cuando falla la carga.
import 'views/failed_view.dart';

// Pantalla principal que contiene la lista de Pokémon cargados exitosamente.
import 'views/contenedor_succes_view.dart/pokemon_list_screen.dart';

/// Punto de entrada principal de la aplicación.
///
/// Configura el [MaterialApp] con el tema general, desactiva la bandera de debug
/// y establece como pantalla inicial una animación con una vista de bienvenida.
void main() {
  runApp(const MyApp());
}

/// Widget raíz de la aplicación.
///
/// Define el tema general y configura la pantalla principal,
/// que inicia con una animación de partículas y la [WelcomeView].
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Color primario del tema general de la aplicación.
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const Scaffold(
        // Contenedor principal que muestra una animación con la vista de bienvenida.
        body: ParticleAnimation(
          // Cambiar este widget permite alternar entre vistas de prueba:
          // - PokemonListScreen: vista principal con los Pokémon.
          // - WaterProgressLoader: animación de carga personalizada.
          // - WelcomeView: pantalla de bienvenida.
          // - TierraErrorView: pantalla en caso de fallo de carga.
          child: WelcomeView(),
        ),
      ),
    );
  }
}

