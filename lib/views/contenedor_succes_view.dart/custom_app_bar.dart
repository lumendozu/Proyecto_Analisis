import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFEF5350),
      elevation: 10,
      shadowColor: Colors.black54,
      centerTitle: true,
      title: const Text(
        'Colección de Cartas',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: 1.5,
          shadows: [
            Shadow(
              blurRadius: 4,
              color: Colors.black38,
              offset: Offset(2, 2),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
