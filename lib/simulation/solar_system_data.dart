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
      orbitRadius: 60,
      orbitSpeed: 1.5,
      parent: sun,
    );
    final venus = CelestialBody(
      name: "Venus",
      radius: 6,
      orbitRadius: 90,
      orbitSpeed: 1.2,
      parent: sun,
    );
    final earth = CelestialBody(
      name: "Earth",
      radius: 10,
      orbitRadius: 120,
      orbitSpeed: 0.8,
      parent: sun,
    );

    final moon = CelestialBody(
      name: "Moon",
      radius: 3,
      orbitRadius: 20,
      orbitSpeed: 2.5,
      parent: earth,
    );
    final mars = CelestialBody(
      name: "Mars",
      radius: 8,
      orbitRadius: 160,
      orbitSpeed: 0.6,
      parent: sun,
    );

    // Planetas externos
    final jupiter = CelestialBody(
      name: "Jupiter",
      radius: 20,
      orbitRadius: 220,
      orbitSpeed: 0.3,
      parent: sun,
    );
    // Luas de Júpiter
    final io = CelestialBody(
      name: "Io",
      radius: 3,
      orbitRadius: 25,
      orbitSpeed: 2,
      parent: jupiter,
    );
    final europa = CelestialBody(
      name: "Europa",
      radius: 2.5,
      orbitRadius: 35,
      orbitSpeed: 1.5,
      parent: jupiter,
    );
    final ganymede = CelestialBody(
      name: "Ganymede",
      radius: 3.5,
      orbitRadius: 45,
      orbitSpeed: 1,
      parent: jupiter,
    );
    final callisto = CelestialBody(
      name: "Callisto",
      radius: 3,
      orbitRadius: 55,
      orbitSpeed: 0.7,
      parent: jupiter,
    );

    final saturn = CelestialBody(
      name: "Saturno",
      radius: 12,
      orbitRadius: 500,
      orbitSpeed: 0.003,
      parent: sun,
    );

    // Montar a hierarquia
    sun.children.addAll([mercury,venus,earth,mars,jupiter,saturn]);
    earth.children.add(moon);
    jupiter.children.addAll([io,europa,ganymede,callisto]);

    return [sun];
  }

}