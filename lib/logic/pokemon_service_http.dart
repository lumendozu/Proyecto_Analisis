// pokemon_service.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonService {
  Future<List<dynamic>> fetchPokemons() async {
    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final results = data['results'] as List;

      // Obtener detalles de cada Pokémon en paralelo para optimizar
      final detailedPokemons = await Future.wait(results.map((pokemon) async {
        final pokemonResponse = await http.get(Uri.parse(pokemon['url']));
        if (pokemonResponse.statusCode == 200) {
          return json.decode(pokemonResponse.body);
        } else {
          throw Exception('Error cargando detalles del Pokémon');
        }
      }));

      return detailedPokemons;
    } else {
      throw Exception('Error cargando la lista de Pokémon');
    }
  }
}

