import 'package:flutter/material.dart';

class TierraErrorView extends StatefulWidget {
  final VoidCallback? onRetry;

  const TierraErrorView({super.key, this.onRetry});

  @override
  State<TierraErrorView> createState() => _TierraErrorViewState();
}

class _TierraErrorViewState extends State<TierraErrorView> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.translate(
                      offset: Offset(0, -5 * (1 - _controller.value)), // sutil rebote
                      child: child,
                    );
                  },
                  child: Icon(
                    Icons.terrain,
                    color: Colors.brown[700],
                    size: 80,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Algo salió mal',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.brown[900],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'No pudimos cargar la Pokédex',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.brown[800],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

