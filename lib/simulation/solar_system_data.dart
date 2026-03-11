// simulation/solar_system_data.dart

import 'celestial_body.dart';

class SolarSystemData {

  static List<CelestialBody> create() {

    final sun = CelestialBody(
      name: "Sun",
      radius: 30,
      orbitRadius: 0,
      orbitSpeed: 0,
    );

    // Definindo os planetas internos
    final mercury = CelestialBody(
      name: "Mercury",
      radius: 4,
      orbitRadius: 50,
      orbitSpeed: 0.02,
      parent: sun,
    );
    final venus = CelestialBody(
      name: "Venus",
      radius: 6,
      orbitRadius: 80,
      orbitSpeed: 0.015,
      parent: sun,
    );
    final earth = CelestialBody(
      name: "Earth",
      radius: 7,
      orbitRadius: 110,
      orbitSpeed: 0.012,
      parent: sun,
    );

    final moon = CelestialBody(
      name: "Moon",
      radius: 2,
      orbitRadius: 20,
      orbitSpeed: 0.05,
      parent: earth,
    );
    final mars = CelestialBody(
      name: "Mars",
      radius: 6,
      orbitRadius: 160,
      orbitSpeed: 0.01,
      parent: sun,
    );

    // Planetas externos
    final jupiter = CelestialBody(
      name: "Jupiter",
      radius: 14,
      orbitRadius: 250,
      orbitSpeed: 0.008,
      parent: sun,
    );
    // Luas de Júpiter
    jupiter.children.addAll([
      CelestialBody(name: "Io"      , radius: 2, orbitRadius: 18, orbitSpeed: 0.03 , parent: jupiter),
      CelestialBody(name: "Europa"  , radius: 2, orbitRadius: 24, orbitSpeed: 0.025, parent: jupiter),
      CelestialBody(name: "Ganymede", radius: 3, orbitRadius: 32, orbitSpeed: 0.02 , parent: jupiter),
      CelestialBody(name: "Callisto", radius: 3, orbitRadius: 40, orbitSpeed: 0.015, parent: jupiter),
    ]);

    final saturn = CelestialBody(
      name: "Saturn",
      radius: 12,
      orbitRadius: 350,
      orbitSpeed: 0.003,
      parent: sun,
    );

    // Montar a hierarquia
    sun.children.addAll([mercury,venus,earth,mars,jupiter,saturn]);
    earth.children.add(moon);

    return [sun];
  }

}
