import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_view.dart';
import '../../logic/pokemon_service_http.dart';
import '../blocs/splash_bloc.dart';
import 'pokeball_icon.dart';
import '../../theme/pokemon_colors.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PokemonColors.background,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('../../assets/images/imgbackground.png'), // Fondo decorativo
            fit: BoxFit.cover,
            opacity: 0.7,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PokeballIcon(), // Icono separado en otro widget

              const SizedBox(height: 20),

              Text(
                "¡Bienvenido Entrenador!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: PokemonColors.textPrimary,
                  shadows: const [
                    Shadow(
                      offset: Offset(1, 2),
                      blurRadius: 3,
                      color: Colors.black26,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Text(
                "¿Listo para empezar?",
                style: TextStyle(
                  fontSize: 18,
                  color: PokemonColors.textSecondary,
                ),
              ),
              const SizedBox(height: 100),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) =>
                            SplashBloc(pokemonService: PokemonService()),
                        child: const WaterProgressLoader(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: PokemonColors.accent,
                  foregroundColor: PokemonColors.blanco,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30, vertical: 14),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 12,
                  shadowColor: PokemonColors.accentDark,
                ),
                icon: const Icon(Icons.play_arrow),
                label: const Text('Comenzar Aventura'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

