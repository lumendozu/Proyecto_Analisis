// pokemon_list_screen.dart
import 'package:flutter/material.dart';
import '../logic/pokemon_service_http.dart';  // Importa el servicio creado

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final PokemonService _pokemonService = PokemonService();

  List<dynamic> pokemons = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPokemons();
  }

  Future<void> _loadPokemons() async {
    try {
      final data = await _pokemonService.fetchPokemons();
      setState(() {
        pokemons = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokémon Cards'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text(errorMessage))
              : GridView.builder(
                  padding: const EdgeInsets.all(10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: pokemons.length,
                  itemBuilder: (context, index) {
                    return PokemonCard(pokemon: pokemons[index]);
                  },
                ),
    );
  }
}

class PokemonCard extends StatelessWidget {
  final dynamic pokemon;

  const PokemonCard({super.key, required this.pokemon});

  Color getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return Colors.redAccent;
      case 'water':
        return Colors.blueAccent;
      case 'grass':
        return Colors.greenAccent;
      case 'electric':
        return Colors.yellowAccent;
      case 'psychic':
        return Colors.purpleAccent;
      case 'ice':
        return Colors.lightBlueAccent;
      case 'dragon':
        return Colors.deepPurpleAccent;
      case 'dark':
        return Colors.brown;
      case 'fairy':
        return Colors.pinkAccent;
      case 'normal':
        return Colors.grey;
      case 'fighting':
        return Colors.orange;
      case 'flying':
        return Colors.lightBlue;
      case 'poison':
        return Colors.purple;
      case 'ground':
        return Colors.brown;
      case 'rock':
        return Colors.grey;
      case 'bug':
        return Colors.lightGreen;
      case 'ghost':
        return Colors.deepPurple;
      case 'steel':
        return Colors.blueGrey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: getTypeColor(pokemon['type'] ?? 'normal'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              pokemon['image'] ?? '',
              height: 100,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
            ),
            const SizedBox(height: 10),
            Text(
              pokemon['name']?.toUpperCase() ?? 'UNKNOWN',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(
              pokemon['type'] ?? 'Unknown Type',
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

