// simulation/selection.dart

import 'celestial_body.dart';

class Selection {
  CelestialBody? selected;

  void select(CelestialBody? body) {
    selected = body;
  }
}
