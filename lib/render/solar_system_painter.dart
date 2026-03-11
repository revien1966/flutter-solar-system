// render/solar_system_painter.dart

import 'package:flutter/material.dart';
import '../simulation/celestial_body.dart';
import 'camera.dart';

class SolarSystemPainter extends CustomPainter {

  final List<CelestialBody> bodies;
  final Camera camera;

  SolarSystemPainter(this.bodies, this.camera);

  @override
  void paint(Canvas canvas, Size size) {

    final screenCenter = Offset(size.width / 2, size.height / 2);
    final planetPaint = Paint();
    final orbitPaint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    void drawBody(CelestialBody body) {

      final world = Offset(body.position.x, body.position.y);
      final screen = camera.worldToScreen(world) + screenCenter;

      // DESENHAR ÓRBITA
      if (body.parent != null) {
        final parentWorld = Offset(
          body.parent!.position.x,
          body.parent!.position.y,
        );
        final parentScreen = camera.worldToScreen(parentWorld) + screenCenter;

        canvas.drawCircle(
          parentScreen,
          body.orbitRadius * camera.zoom,
          orbitPaint,
        );
      } // endif

      // COR DO CORPO
      switch (body.name) {
        case "Sun":
          planetPaint.color = Colors.orange;
          break;
        case "Mercury":
          planetPaint.color = Colors.grey;
          break;
        case "Venus":
          planetPaint.color = Colors.yellowAccent;
          break;
        case "Earth":
          planetPaint.color = Colors.blue;
          break;
        case "Moon":
          planetPaint.color = Colors.grey.shade300;
          break;
        case "Mars":
          planetPaint.color = Colors.redAccent;
          break;
        case "Jupiter":
          planetPaint.color = Colors.brown;
          break;
        case "Io":
          planetPaint.color = Colors.orangeAccent;
          break;
        case "Europa":
          planetPaint.color = Colors.white70;
          break;
        case "Ganymede":
          planetPaint.color = Colors.grey;
          break;
        case "Callisto":
          planetPaint.color = Colors.grey.shade600;
          break;
        default:
          planetPaint.color = Colors.white;
      }

      // DESENHAR PLANETA
      canvas.drawCircle(
        screen,
        body.radius * camera.zoom,
        planetPaint,
      );

      // DESENHAR FILHOS (Luas)
      for (final child in body.children) {
        drawBody(child);
      }

    }

    for (final body in bodies) {
      drawBody(body);
    }

  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

}