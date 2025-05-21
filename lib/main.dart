import 'package:flutter/material.dart';
import 'animations/particle_animation.dart';
import 'views/welcome_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Scaffold(
        body: ParticleAnimation(
          child: WelcomeView(),
        ),
      ),
    );
  }
}
