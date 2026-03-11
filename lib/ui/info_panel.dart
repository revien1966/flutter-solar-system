// ui/info_panel.dart

import 'package:flutter/material.dart';
import '../simulation/celestial_body.dart';

class InfoPanel extends StatelessWidget {
  final CelestialBody? body;

  const InfoPanel({super.key, this.body});

  @override
  Widget build(BuildContext context) {
    if (body == null) return const SizedBox.shrink();

    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.75),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.blueAccent.withOpacity(0.6),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              body!.name,
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text("Raio: ${body!.radius}",
              style: const TextStyle(color: Colors.white)),
            Text("Órbita: ${body!.orbitRadius}",
              style: const TextStyle(color: Colors.white)),
            Text("Velocidade: ${body!.orbitSpeed}",
              style: const TextStyle(color: Colors.white)),
            if (body!.children.isNotEmpty)
               const SizedBox(height:8),
            if (body!.children.isNotEmpty)
               Text("Luas: ${body!.children.map((c) => c.name).join(', ')}",
              style: const TextStyle(color: Colors.yellow)),
          ],
        ),
      ),
    );
  }
}