import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

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

    // Barra de progreso
    _progressTimer = Timer.periodic(const Duration(milliseconds: 20), (timer) {
      setState(() {
        if (_progress < 0.88) {
          _progress += 0.01;
        } else {
          _progress = 0.88;
          _progressTimer?.cancel();
        }
      });
    });

    // Lluvia de gotas
    _dropTimer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      if (mounted) {
        final screenWidth = MediaQuery.of(context).size.width;
        setState(() {
          _drops.add(_Drop(
            key: UniqueKey(),
            left: Random().nextDouble() * screenWidth,
            duration: 1000 + Random().nextInt(1200),
          ));

          // Mantén solo 30 gotas activas
          if (_drops.length > 30) {
            _drops.removeAt(0);
          }
        });
      }
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

    return Container(
      color: Colors.blue.shade50,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          // Gotas que caen
          ..._drops.map((drop) => drop.withMaxHeight(screenHeight)),

          // Contenido principal
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
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.lightBlueAccent),
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
    );
  }
}

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

