// core/math/vector2.dart
import 'dart:math';

class Vector2 {

  double x;
  double y;

  Vector2(this.x, this.y);

  Vector2.zero() : x = 0, y = 0;

  double length() {
    return sqrt(x * x + y * y);
  }

  void add(Vector2 other) {
    x += other.x;
    y += other.y;
  }

}