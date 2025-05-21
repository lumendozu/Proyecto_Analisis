import 'package:flutter/material.dart';
import 'dart:math';
import 'particle.dart';
import 'particle_painter.dart';

class ParticleAnimation extends StatefulWidget {
  final Widget child;
  
  const ParticleAnimation({super.key, required this.child});

  @override
  State<ParticleAnimation> createState() => _ParticleAnimationState();
}

class _ParticleAnimationState extends State<ParticleAnimation> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<Particle> particles = [];
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(days: 365),
      vsync: this,
    )..addListener(_updateParticles)
     ..repeat();
  }

  void _updateParticles() {
    setState(() {
      if (random.nextDouble() < 0.3) {
        particles.add(_generateParticle());
      }

      particles = particles.where((p) => p.isAlive).toList();
      for (var p in particles) {
        p.update();
      }
    });
  }

  Particle _generateParticle() {
    double x, y;
    int side = random.nextInt(4);
    switch (side) {
      case 0: x = 0; y = random.nextDouble(); break;
      case 1: x = 1; y = random.nextDouble(); break;
      case 2: x = random.nextDouble(); y = 0; break;
      default: x = random.nextDouble(); y = 1; break;
    }

    final colors = [
      Colors.deepOrangeAccent.withOpacity(0.7),
      Colors.amberAccent.withOpacity(0.7),
      Colors.orange.withOpacity(0.6),
      Colors.redAccent.withOpacity(0.5),
      Colors.white.withOpacity(0.4),
    ];

    final velocity = Offset(
      (random.nextDouble() - 0.5) * 0.004,
      (random.nextDouble() - 0.5) * 0.004,
    );

    return Particle(
      position: Offset(x, y),
      velocity: velocity,
      size: random.nextDouble() * 2 + 0.5,
      color: colors[random.nextInt(colors.length)],
      life: random.nextDouble() * 3 + 1,
    );
  }

  LinearGradient _buildAnimatedGradient(double value) {
    return LinearGradient(
      colors: [
        Color.lerp(Colors.deepOrange[900], Colors.black, value)!,
        Color.lerp(Colors.red[900], Colors.deepOrange[800], 1 - value)!,
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
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
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              decoration: BoxDecoration(
                gradient: _buildAnimatedGradient(
                  sin(_controller.value * 2 * pi) * 0.5 + 0.5,
                ),
              ),
              child: Stack(
                children: [
                  CustomPaint(
                    painter: ParticlePainter(
                      particles,
                      constraints.maxWidth,
                      constraints.maxHeight,
                    ),
                  ),
                  widget.child,
                ],
              ),
            );
          },
        );
      },
    );
  }
}
