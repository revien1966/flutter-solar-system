// simulation/simulation_engine.dart

import 'celestial_body.dart';

class SimulationEngine {
  final List<CelestialBody> rootBodies;

  SimulationEngine(this.rootBodies);

  void update(double dt) {
    for (final body in rootBodies) {
      body.update(dt);
    }
  }

}