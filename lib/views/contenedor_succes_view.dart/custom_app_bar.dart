import 'package:flutter/material.dart';

/// AppBar personalizada que se utiliza en la mayoría de las pantallas de la app.
/// Presenta un título centrado con estilo visual acorde al tema de Pokémon.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFEF5350), // Rojo tipo Pokémon
      elevation: 10, // Sombra para dar profundidad
      shadowColor: Colors.black54,
      centerTitle: true,
      title: const Text(
        'Colección de Cartas',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.5,
          shadows: [
            Shadow(
              blurRadius: 4,
              color: Colors.black38,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }

  /// Define el tamaño preferido del AppBar, requerido por PreferredSizeWidget.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

