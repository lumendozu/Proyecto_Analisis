import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/pokemon_service_http.dart';
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
  Timer? _dropTimer;
  final List<_Drop> _drops = [];

  @override
  void initState() {
    super.initState();

    // Arrancamos la animación de la barra local (sin depender del BLoC)
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

    // Animación de gotas (idéntico a antes)
    _dropTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (mounted) {
        final screenWidth = MediaQuery.of(context).size.width;
        setState(() {
          _drops.add(_Drop(
            key: UniqueKey(),
            left: Random().nextDouble() * screenWidth,
            duration: 1000 + Random().nextInt(1200),
          ));
          if (_drops.length > 30) {
            _drops.removeAt(0);
          }
        });
      }
    });

    // En cuanto la pantalla aparece, disparamos el evento para cargar pokémons:
    // El BlocProvider se provee más abajo. Aquí solo hacemos el add del evento.
    Future.microtask(() {
      context.read<SplashBloc>().add(SplashLoadPokemons());
    });
  }

  @override
  void dispose() {
    _progressTimer?.cancel();
    _dropTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashLoadSuccess) {
          // Si cargó bien, reemplazamos la pantalla por PokemonListScreen:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const PokemonListScreen()),
          );
        } else if (state is SplashLoadFailure) {
          // Si hay falla, vamos a TierraErrorView:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => TierraErrorView(
                onRetry: () {
                  // Al darle “Intentar de nuevo”, volvemos a instanciar la pantalla de loader con un nuevo BLoC
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
          child: Stack(
            children: [
              // Gotas
              ..._drops.map((drop) => drop.withMaxHeight(screenHeight)),

              // Contenido central
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('${(_progress * 100).toInt()}%'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Clase interna para las gotas (sin cambios):
class _Drop extends StatefulWidget {
  final double left;
  final int duration;
  final double? maxHeight;

  const _Drop({
    required Key key,
    required this.left,
    required this.duration,
    this.maxHeight,
  }) : super(key: key);

  Widget withMaxHeight(double height) {
    return _Drop(
      key: key!,
      left: left,
      duration: duration,
      maxHeight: height,
    );
  }

  @override
  State<_Drop> createState() => _DropState();
}

class _DropState extends State<_Drop> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _top;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );
    _top = Tween<double>(
      begin: -20,
      end: widget.maxHeight ?? 800,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Positioned(
          top: _top.value,
          left: widget.left,
          child: Opacity(
            opacity: 0.5,
            child: Icon(Icons.water_drop, color: Colors.lightBlueAccent, size: 18),
          ),
        );
      },
    );
  }
}

