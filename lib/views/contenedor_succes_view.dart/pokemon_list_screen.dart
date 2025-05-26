import 'package:flutter/material.dart';
import '../../logic/pokemon_service_http.dart';
import 'custom_app_bar.dart';
import 'search_bar.dart';
import 'pokemon_card.dart';

class PokemonListScreen extends StatefulWidget {
  const PokemonListScreen({super.key});

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  final PokemonService _pokemonService = PokemonService();
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> pokemons = [];
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadPokemons();
  }

  Future<void> _loadPokemons() async {
    try {
      final data = await _pokemonService.fetchPokemonsWithProgress(
        onProgress: (current, total) {
        },
      );
      setState(() {
        pokemons = data;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  void _searchPokemon() {
    final query = _searchController.text.trim().toLowerCase();
    final result = pokemons.firstWhere(
      (poke) => poke['name'].toString().toLowerCase() == query,
      orElse: () => {},
    );

    if (result.isNotEmpty) {
      _showPokemonDialog(result);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pokémon no encontrado en la lista de los 50 primero pokemones')),
      );
    }
  }

  void _showPokemonDialog(Map<String, dynamic> pokemon) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            PokemonCard(pokemon: pokemon),
            Positioned(
              top: 0,
              right: 0,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shufflePokemons() => setState(() => pokemons.shuffle());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (errorMessage.isNotEmpty) {
      return Center(child: Text(errorMessage));
    }

    return Column(
      children: [
        SearchBarWidget(
          controller: _searchController,
          onSearch: _searchPokemon,
          onShuffle: _shufflePokemons,
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.65,
            ),
            itemCount: pokemons.length >= 50 ? 50 : pokemons.length,
            itemBuilder: (context, index) => PokemonCard(pokemon: pokemons[index]),
          ),
        ),
      ],
    );
  }
}


