import 'package:http/http.dart' as http;
import 'dart:convert';

/// Servicio encargado de obtener datos de Pokémon desde la API pública pokeapi.co.
class PokemonService {
  /// Obtiene una lista de Pokémon con sus detalles completos (id, nombre, tipos, imagen y stats).
  ///
  /// Este método hace dos tipos de solicitudes:
  /// 1. Una solicitud inicial para obtener la lista básica de 50 Pokémon.
  /// 2. Una solicitud por cada Pokémon para obtener sus detalles.
  ///
  /// Se utiliza [onProgress] para notificar el avance de la carga (útil para mostrar en UI).
  Future<List<Map<String, dynamic>>> fetchPokemonsWithProgress({
    required Function(int current, int total) onProgress,
  }) async {
    try {
      final response = await http.get(
        Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=50'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        final total = results.length;

        List<Map<String, dynamic>> detailedPokemons = [];

        for (int i = 0; i < results.length; i++) {
          final pokemon = results[i];
          final pokemonResponse = await http.get(Uri.parse(pokemon['url']));

          if (pokemonResponse.statusCode == 200) {
            final pokemonData = json.decode(pokemonResponse.body);

            detailedPokemons.add({
              'id': pokemonData['id'] ?? 0,
              'name': pokemonData['name']?.toString() ?? 'Unknown',
              'types': (pokemonData['types'] as List?)?.map<String>(
                        (t) => t['type']['name'].toString().toLowerCase(),
                      ).toList() ??
                  [],
              'image': pokemonData['sprites']['other']['official-artwork']
                          ['front_default'] ??
                      pokemonData['sprites']['front_default'] ??
                      '',
              'stats': {
                'hp': pokemonData['stats'][0]['base_stat'] ?? 0,
                'attack': pokemonData['stats'][1]['base_stat'] ?? 0,
                'defense': pokemonData['stats'][2]['base_stat'] ?? 0,
              }
            });
          }

          // Actualiza el progreso después de procesar cada Pokémon.
          onProgress(i + 1, total);
        }

        return detailedPokemons;
      }

      throw Exception('Failed to load pokémons: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}

