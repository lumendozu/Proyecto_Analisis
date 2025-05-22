import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_view.dart';
import '../../logic/pokemon_service_http.dart';
import '../blocs/splash_bloc.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.local_fire_department,
                color: Colors.amberAccent,
                size: 60,
              ),
              const SizedBox(height: 10),
              Text(
                "Bienvenido",
                style: TextStyle(
                  fontSize: 34,
                  color: Colors.orange[100],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 150),
          ElevatedButton(
            onPressed: () {
              // Navegamos a la pantalla de loader, pero inyectando el SplashBloc:
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => SplashBloc(pokemonService: PokemonService()),
                    child: const WaterProgressLoader(),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrangeAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              textStyle:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              shadowColor: Colors.orangeAccent,
              elevation: 10,
            ).copyWith(
              backgroundColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.hovered)) {
                  return Colors.redAccent;
                }
                return Colors.deepOrange;
              }),
            ),
            child: const Text('Ingresar'),
          ),
        ],
      ),
    );
  }
}

