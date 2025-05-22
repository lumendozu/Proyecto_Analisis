// pokemon_service_http.dart
import 'package:http/http.dart' as http;
import 'dart:convert';

class PokemonService {
  Future<List<Map<String, dynamic>>> fetchPokemons() async {
    try {
      final response = await http.get(
          Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=130'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        
        List<Map<String, dynamic>> detailedPokemons = [];
        for (var pokemon in results) {
          final pokemonResponse = await http.get(Uri.parse(pokemon['url']));
          if (pokemonResponse.statusCode == 200) {
            final pokemonData = json.decode(pokemonResponse.body);
            
            detailedPokemons.add({
              'id': pokemonData['id'] ?? 0,
              'name': pokemonData['name']?.toString() ?? 'Unknown',
              'types': (pokemonData['types'] as List?)?.map<String>((t) => 
                t['type']['name'].toString().toLowerCase()).toList() ?? [],
              'image': pokemonData['sprites']['other']['official-artwork']['front_default'] ?? 
                      pokemonData['sprites']['front_default'] ?? '',
              'stats': {
                'hp': pokemonData['stats'][0]['base_stat'] ?? 0,
                'attack': pokemonData['stats'][1]['base_stat'] ?? 0,
                'defense': pokemonData['stats'][2]['base_stat'] ?? 0,
              }
            });
          }
        }
        return detailedPokemons;
      }
      throw Exception('Failed to load pokémons: ${response.statusCode}');
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
