import 'package:flutter/material.dart';
import 'particle.dart';

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final double width;
  final double height;

  ParticlePainter(this.particles, this.width, this.height);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    for (final p in particles) {
      if (p.size > 0 && p.life > 0) {
        final dx = (p.position.dx * width).clamp(0.0, width);
        final dy = (p.position.dy * height).clamp(0.0, height);
        paint.color = p.color.withOpacity((p.life / 4).clamp(0.0, 1.0));
        canvas.drawCircle(Offset(dx, dy), p.size, paint);
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
