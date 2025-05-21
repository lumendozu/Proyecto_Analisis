import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Básico',
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        body: SizedBox.expand( // <- fuerza a ocupar todo el espacio
          child: Column(
            children: [
              SizedBox(height: 500), // posición vertical del botón
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // centrado horizontal
                children: [
                  ElevatedButton(
                    onPressed: null,
                    child: Text('siguiente ->'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

