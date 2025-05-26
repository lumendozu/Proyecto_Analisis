import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/pokemon_service_http.dart';
import 'contenedor_succes_view.dart/pokemon_list_screen.dart';
import 'failed_view.dart';
import '../blocs/splash_bloc.dart';
import '../blocs/splash_event.dart';
import '../blocs/splash_state.dart';

class WaterProgressLoader extends StatefulWidget {
  const WaterProgressLoader({super.key});

  @override
  State<WaterProgressLoader> createState() => _WaterProgressLoaderState();
}

class _WaterProgressLoaderState extends State<WaterProgressLoader> {
  double _progress = 0.0;
  Timer? _progressTimer;

  @override
  void initState() {
    super.initState();

    // Simulación de progreso sin animaciones visuales adicionales
    _progressTimer = Timer.periodic(const Duration(milliseconds: 60), (timer) {
      setState(() {
        if (_progress < 0.99) {
          _progress += 0.01;
        } else {
          _progress = 0.99;
          _progressTimer?.cancel();
        }
      });
    });

    // Lanzar evento de carga de Pokémon al inicio
    Future.microtask(() {
      context.read<SplashBloc>().add(SplashLoadPokemons());
    });
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoadSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const PokemonListScreen()),
          );
        } else if (state is SplashLoadFailure) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => TierraErrorView(
                onRetry: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (_) => SplashBloc(pokemonService: PokemonService()),
                        child: const WaterProgressLoader(),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Container(
          color: Colors.blue.shade50,
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ícono estático
                Icon(Icons.water_drop, size: 60, color: Colors.blueAccent),
                const SizedBox(height: 20),
                const Text(
                  'Cargando Pokédex...',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _progress,
                      minHeight: 15,
                      backgroundColor: Colors.blue.shade100,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text('${(_progress * 100).toInt()}%'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

