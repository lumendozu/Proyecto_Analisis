// widgets/pokemon_card.dart
import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  final Map<String, dynamic> pokemon;

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
        return Colors.amber;
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

//	Color getStatBarColor(Color baseColor) {
//		final luminance = baseColor.computeLuminance();
//		if (luminance > 0.6) {
//			return Colors.black87;
//		} else if (luminance < 0.1) {
//			return Colors.white;
//		} else {
			// Para tonos medios usamos un color que resalte bien
//			return baseColor.withRed(300); // Ej: hace el color más brillante
//		}
//	}


  Color getStatBarColor(Color baseColor) {
    return baseColor.computeLuminance() > 0.9 ? Colors.black : baseColor;
  }

  @override
  Widget build(BuildContext context) {
    final String name = pokemon['name']?.toString() ?? 'Unknown';
    final int id = pokemon['id'] as int? ?? 0;
    final List<String> types =
        (pokemon['types'] as List<dynamic>?)?.cast<String>() ?? [];
    final String imageUrl = pokemon['image']?.toString() ?? '';
    final Map<String, dynamic> stats =
        pokemon['stats'] as Map<String, dynamic>? ?? {};

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        final baseSize = width < height ? width : height;
				final Color textColor = const Color(0xFFB0C4DE); // Azul grisáceo claro
				

        final Color typeColor =
            types.isNotEmpty ? getTypeColor(types[0]) : Colors.grey;

        return Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          clipBehavior: Clip.antiAlias,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  typeColor.withOpacity(0.9),
                  typeColor.withOpacity(0.1),
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(baseSize * 0.05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ID + Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '#${id.toString().padLeft(3, '0')}',
                        style: TextStyle(
                          fontSize: baseSize * 0.07,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                      Expanded(
                        child: Text(
                          name.toUpperCase(),
                          textAlign: TextAlign.right,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: baseSize * 0.07,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: baseSize * 0.03),

                  // Imagen con tamaño fijo
                  SizedBox(
                    height: baseSize * 0.58,
                    child: Center(
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        width: baseSize * 0.6,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.error, color: Colors.white),
                        loadingBuilder: (context, child, progress) =>
                            progress == null
                                ? child
                                : const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                  SizedBox(height: baseSize * 0.03),

                  // Tipos con chips optimizados
                  Wrap(
                    spacing: baseSize * 0.02,
                    runSpacing: baseSize * 0.01,
                    children: types.isNotEmpty
                        ? types.map((type) {
                            return Chip(
                              label: Text(
                                type.toUpperCase(),
                                style: TextStyle(
                                  fontSize: baseSize * 0.05,
                                  color: Colors.white,
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: baseSize * 0.03,
                                vertical: baseSize * 0.01,
                              ),
                              backgroundColor: getTypeColor(type).withOpacity(0.8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(baseSize * 0.02),
                              ),
                            );
                          }).toList()
                        : [
                            Chip(
                              label: Text(
                                'UNKNOWN',
                                style: TextStyle(
                                  fontSize: baseSize * 0.05,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(baseSize * 0.02),
                              ),
                            ),
                          ],
                  ),
                  SizedBox(height: baseSize * 0.03),

                  // Stats
                  ...['hp', 'attack', 'defense'].map((stat) {
                    final int value = (stats[stat] as int?) ?? 0;
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: baseSize * 0.005),
                      child: Row(
                        children: [
                          SizedBox(
                            width: baseSize * 0.4,
                            child: Text(
                              stat.toUpperCase(),
                              style: TextStyle(
                                fontSize: baseSize * 0.06,
                          			color: Colors.grey[800],
                              ),
                            ),
                          ),
                          Expanded(
                            child: LinearProgressIndicator(
                              value: value / 100,
                              backgroundColor: Colors.grey[300],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                getStatBarColor(typeColor),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: baseSize * 0.15,
                            child: Text(
                              value.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: baseSize * 0.07,
                          			color: Colors.grey[800],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

