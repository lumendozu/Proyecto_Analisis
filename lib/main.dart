//import 'package:aplication/views/succes_view.dart';
import 'package:flutter/material.dart';
import 'animations/animation_init/particle_animation.dart';
import 'views/init_view.dart';
import 'views/loading_view.dart';
import 'views/failed_view.dart';
import 'views/contenedor_succes_view.dart/pokemon_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
    		primarySwatch: Colors.blue,
      	visualDensity: VisualDensity.adaptivePlatformDensity,
			),
      home: const Scaffold(
        body: ParticleAnimation(
				// PokemonListScreen
				// WaterProgressLoader
				// WelcomeView
				// TierraErrorView	
          child: WelcomeView(),
        ),
      ),
    );
  }
}
