// simulation/celestial_body.dart

import '../core/math/vector2.dart';
import '../core/math/orbit_math.dart';

class CelestialBody {

  final String name;

  final double radius;
  final double orbitRadius;
  final double orbitSpeed;

  double angle = 0;

  Vector2 position = Vector2.zero();

  final CelestialBody? parent;

  final List<CelestialBody> children = [];

  //Offset position = Offset.zero;

  CelestialBody({
    required this.name,
    required this.radius,
    required this.orbitRadius,
    required this.orbitSpeed,
    this.parent,
    //this.children = const [],
  });

  void update(double dt) {

    angle += orbitSpeed * dt;

    if (parent != null) {

      //final px = parent!.position.dx;
      //final py = parent!.position.dy;
      position = orbitPosition(
        parent!.position,
        orbitRadius,
        angle,
      );

    }

    for (final child in children) {
      child.update(dt);
    }
  }

}