import 'package:flutter/material.dart';

/// Clase que centraliza todos los colores usados en la app relacionados con Pokémon.
/// Permite mantener el estilo visual consistente y facilita cambios futuros.
class PokemonColors {
  /// === COLORES BASE DE LA APLICACIÓN ===

  /// Fondo claro general de la app (amarillo suave)
  static const Color background = Color(0xFFFFF8E1);

  /// Color de acento principal (para botones e íconos)
  static const Color accent = Colors.amber;

  /// Variante más brillante del acento (para sombras, hover)
  static const Color accentDark = Colors.amberAccent;

  /// Texto principal (marrón)
  static const Color textPrimary = Color(0xFF795548);

  /// Texto secundario (marrón más claro)
  static const Color textSecondary = Color(0xFF8D6E63);

  /// Color blanco constante (puede usarse en temas claros/oscurecidos).
  static const Color blanco = Colors.white;

  /// Color equivalente a Colors.grey[800] — ideal para texto oscuro.
  static const Color azulGrisOscuro = Color(0xFF424242);

  /// === COLORES POR TIPO DE POKÉMON ===

  /// Color por defecto si un tipo de Pokémon no está definido.
  static const Color defaultColor = Colors.grey;

  /// Mapa que asocia cada tipo de Pokémon con un color específico.
  /// Se usa para fondos, chips de tipo, y barras de stats.
  static const Map<String, Color> typeColors = {
    'fire': Colors.redAccent,
    'water': Colors.blueAccent,
    'grass': Colors.greenAccent,
    'electric': Colors.amber,
    'psychic': Colors.purpleAccent,
    'ice': Colors.lightBlueAccent,
    'dragon': Colors.deepPurpleAccent,
    'dark': Colors.brown,
    'fairy': Colors.pinkAccent,
    'normal': Colors.grey,
    'fighting': Colors.orange,
    'flying': Colors.lightBlue,
    'poison': Colors.purple,
    'ground': Colors.brown,
    'rock': Colors.grey,
    'bug': Colors.lightGreen,
    'ghost': Colors.deepPurple,
    'steel': Colors.blueGrey,
  };

  /// Retorna el color correspondiente al tipo de Pokémon recibido.
  /// Si no existe, devuelve el color por defecto.
  static Color getTypeColor(String type) {
    return typeColors[type.toLowerCase()] ?? defaultColor;
  }

  /// Determina el color más visible para la barra de estadísticas,
  /// evitando que se use blanco sobre blanco.
  static Color getStatBarColor(Color baseColor) {
    return baseColor.computeLuminance() > 0.9 ? Colors.black : baseColor;
  }
}

