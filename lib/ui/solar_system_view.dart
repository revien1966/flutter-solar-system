// ui/solar_system_view.dart

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:math' as math;

import '../core/time/game_clock.dart';
import '../simulation/selection.dart';
import '../simulation/simulation_engine.dart';
import '../simulation/solar_system_data.dart';
import '../simulation/celestial_body.dart';
import '../render/camera.dart';
import '../render/star.dart';
import '../render/solar_system_painter.dart';
import 'info_panel.dart';

class SolarSystemView extends StatefulWidget {
  const SolarSystemView({super.key});

  @override
  State<SolarSystemView> createState() => _SolarSystemViewState();
}

class _SolarSystemViewState extends State<SolarSystemView> {
  late SimulationEngine engine;
  late GameClock clock;
  late Camera camera;
  late List<Star> stars;

  final selection = Selection();
  CelestialBody? hovered;

  @override
  void initState() {
    super.initState();

    final random = math.Random();

    stars = List.generate(800, (_) {

      return Star(
        position: Offset(
          random.nextDouble() * 8000 - 4000,
          random.nextDouble() * 8000 - 4000,
        ),
        depth: random.nextDouble(),
        size: random.nextDouble() * 1.5 + 0.5,
      );
    });

    final bodies = SolarSystemData.create();
    engine = SimulationEngine(bodies);
    camera = Camera();

    clock = GameClock();
    clock.start((dt) {
      engine.update(dt);

      // Atualiza a câmera se houver seleção para foco
      // Foco suave da câmera no corpo selecionado
      if (selection.selected != null) {
        final target = selection.selected!;
        final targetScreen = Offset(target.position.x, target.position.y);
        camera.position += (targetScreen - camera.position) * 0.02; // mais lento
      }

      setState(() {});
    });
  }

  // Encontrar o corpo mais próximo
  CelestialBody? _findNearestBody(
    CelestialBody body,
    Offset pointer,
    Offset center,
    double maxDistance,
  ) {
    CelestialBody? nearest;
    double nearestDist = maxDistance;

    final bodyScreen =
        camera.worldToScreen(Offset(body.position.x, body.position.y)) + center;

    final dist = (pointer - bodyScreen).distance;

    if (dist < nearestDist) {
      nearestDist = dist;
      nearest = body;
    }

    for (final child in body.children) {
      final candidate =
          _findNearestBody(child, pointer, center, nearestDist);

      if (candidate != null) {
        final candidateScreen = camera.worldToScreen(
                Offset(candidate.position.x, candidate.position.y)) +
            center;

        final d = (pointer - candidateScreen).distance;

        if (d < nearestDist) {
          nearestDist = d;
          nearest = candidate;
        }
      }
    }

    return nearest;
  }

  // Recursivo: verifica se clicou no corpo
  CelestialBody? _hitTest(CelestialBody body, Offset click, Offset center) {
    final bodyScreen = camera.worldToScreen(Offset(body.position.x, body.position.y)) + center;

    // Raio clicável maior que o raio real
    final clickableRadius = body.radius * camera.zoom + 8; // +8 pixels de tolerância
    if ((click - bodyScreen).distance <= clickableRadius) {
      return body;
    }

    for (final child in body.children) {
      final hit = _hitTest(child, click, center);
      if (hit != null) return hit;
    }
    return null;
  }

  //.....
  void _handleHover(Offset position) {

    final center = Offset(
      MediaQuery.of(context).size.width / 2,
      MediaQuery.of(context).size.height / 2,
    );

    CelestialBody? nearest;

    for (final root in engine.rootBodies) {
      final candidate =
          _findNearestBody(root, position, center, 40);

      if (candidate != null) {
        nearest = candidate;
      }
    }

    setState(() {
      hovered = nearest;
    });

  }

  //...............
  void _handleClick(Offset position) {

    final center = Offset(
      MediaQuery.of(context).size.width / 2,
      MediaQuery.of(context).size.height / 2,
    );

    CelestialBody? nearest;

    for (final root in engine.rootBodies) {
      final candidate =
          _findNearestBody(root, position, center, 40);

      if (candidate != null) {
        nearest = candidate;
      }
    }

    setState(() {
      selection.select(nearest);
    });

  }

  @override
  Widget build(BuildContext context) {
    final screenCenter = Offset(MediaQuery.of(context).size.width / 2, MediaQuery.of(context).size.height / 2);

    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScrollEvent) {
          setState(() {
            const zoomFactor = 1.05; // mais suave
            if (event.scrollDelta.dy > 0) {
              camera.zoom /= zoomFactor;
            } else {
              camera.zoom *= zoomFactor;
            }
            camera.zoom = camera.zoom.clamp(0.1, 20.0);
          });
        }
      },

      child: MouseRegion(
        onHover: (event) {
          _handleHover(event.localPosition);
        },
        child: GestureDetector(

        onPanUpdate: (DragUpdateDetails details) {
          setState(() {
            camera.position -= details.delta / camera.zoom;
          });
        },

        //...................................
        onTapDown: (TapDownDetails details) {
          _handleClick(details.localPosition);
        },

        //...........
        child: Stack(
          children: [
            CustomPaint(
              painter: SolarSystemPainter(
                engine.rootBodies,
                camera,
                hovered,
                selection.selected,
                stars,
              ),
              size: Size.infinite,
            ),
            InfoPanel(body: selection.selected),
          ],
        ),
      ),
      )
    );
  }

}
