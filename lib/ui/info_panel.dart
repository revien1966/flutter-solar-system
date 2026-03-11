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
          color: Colors.black87,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.white24),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              body!.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text("Raio: ${body!.radius}"),
            Text("Órbita: ${body!.orbitRadius}"),
            Text("Velocidade: ${body!.orbitSpeed}"),
            if (body!.children.isNotEmpty)
              Text("Luas: ${body!.children.map((c) => c.name).join(', ')}"),
          ],
        ),
      ),
    );
  }
}