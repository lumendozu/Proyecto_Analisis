import 'dart:ui';

class Particle {
  Offset position;
  Offset velocity;
  double size;
  Color color;
  double life;

  Particle({
    required this.position,
    required this.velocity,
    required this.size,
    required this.color,
    required this.life,
  });

  void update() {
    position += velocity;
    life -= 0.008;
  }

  bool get isAlive => life > 0;
}
