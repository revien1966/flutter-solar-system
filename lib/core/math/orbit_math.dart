// core/math/orbit_math.dart
import 'dart:math';
import 'vector2.dart';

Vector2 orbitPosition(
  Vector2 center,
  double radius,
  double angle,
) {

  final x = center.x + radius * cos(angle);
  final y = center.y + radius * sin(angle);

  return Vector2(x, y);

}