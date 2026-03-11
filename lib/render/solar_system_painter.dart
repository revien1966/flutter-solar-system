// render/solar_system_painter.dart

import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../simulation/celestial_body.dart';
import 'camera.dart';
import 'star.dart';

class SolarSystemPainter extends CustomPainter {
  final List<CelestialBody> bodies;
  final Camera camera;
  final CelestialBody? hovered;
  final CelestialBody? selected;
  final List<Star> stars;

  SolarSystemPainter(
    this.bodies,
    this.camera,
    this.hovered,
    this.selected,
    this.stars,
  );

  @override
  void paint(Canvas canvas, Size size) {
    final screenCenter = Offset(size.width / 2, size.height / 2);
    final planetPaint = Paint();
    final orbitPaint = Paint()
      ..color = Colors.white24
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    final starPaint = Paint();

    for (final star in stars) {
      final world = star.position * star.depth;
      final screen = camera.worldToScreen(world) + screenCenter;
      starPaint.color = Colors.white.withOpacity(0.5 + star.depth * 0.5);
      canvas.drawCircle(
        screen,
        star.size,
        starPaint,
      );
    }

    void drawBody(CelestialBody body) {
      final world = Offset(body.position.x, body.position.y);
      final screen = camera.worldToScreen(world) + screenCenter;

      // DESENHAR ÓRBITA
      if (body.parent != null) {
        final parentWorld = Offset(body.parent!.position.x, body.parent!.position.y, );
        final parentScreen = camera.worldToScreen(parentWorld) + screenCenter;

        // órbitas pontilhadas
        const segments = 90;
        for (int i = 0; i < segments; i++) {
          final angle1 = (i / segments) * 2 * math.pi;
          final angle2 = ((i + 0.5) / segments) * 2 * math.pi;

          final p1 = Offset(
            parentScreen.dx + math.cos(angle1) * body.orbitRadius * camera.zoom,
            parentScreen.dy + math.sin(angle1) * body.orbitRadius * camera.zoom,
          );

          final p2 = Offset(
            parentScreen.dx + math.cos(angle2) * body.orbitRadius * camera.zoom,
            parentScreen.dy + math.sin(angle2) * body.orbitRadius * camera.zoom,
          );

          canvas.drawLine(p1, p2, orbitPaint);
        }
      }

      // COR DO CORPO
      switch (body.name) {
        case "Sun"     : planetPaint.color = Colors.orange; break;
        case "Mercury" : planetPaint.color = Colors.grey;   break;
        case "Venus"   : planetPaint.color = Colors.yellowAccent; break;
        case "Earth"   : planetPaint.color = Colors.blue;         break;
        case "Moon"    : planetPaint.color = Colors.grey.shade300; break;
        case "Mars"    : planetPaint.color = Colors.redAccent;     break;
        case "Jupiter" : planetPaint.color = Colors.brown;         break;
        case "Io"      : planetPaint.color = Colors.orangeAccent;  break;
        case "Europa"  : planetPaint.color = Colors.white70;       break;
        case "Ganymede": planetPaint.color = Colors.grey;          break;
        case "Callisto": planetPaint.color = Colors.grey.shade600; break;
        case "Saturn"  : planetPaint.color = Colors.purple;        break;
        default        : planetPaint.color = Colors.white;
      }

      // DESTACAR HOVER
      if (body == hovered) planetPaint.color = Colors.white;
      // DESTACAR SELECIONADO
      if (body == selected) planetPaint.color = Colors.yellow;

      // DESENHAR PLANETA
      canvas.drawCircle(screen, body.radius * camera.zoom, planetPaint);

      // Modificações para Saturno com seus anéis
      if (body.name == "Saturn") {
        final ringPaint = Paint()
          ..color = Colors.brown.withOpacity(0.6)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

        // Salva o estado atual do canvas
        canvas.save();
        // Move o canvas para o centro do planeta
        canvas.translate(screen.dx, screen.dy);
        // Rotacionar para inclinar o anel
        canvas.rotate(-0.5);

        // Desenhar o anel com um oval
        canvas.drawOval(
          Rect.fromCenter(
            center: Offset.zero,
            width: body.radius * camera.zoom * 5,
            height: body.radius * camera.zoom * 2,
          ),
          ringPaint,
        );
        // Restaura o canvas
        canvas.restore();
      }

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