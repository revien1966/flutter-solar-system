// render/camera.dart

import 'dart:ui';

class Camera {

  Offset position = Offset.zero;

  double zoom = 1.0;

  Offset worldToScreen(Offset world) {

    return Offset(
      (world.dx - position.dx) * zoom,
      (world.dy - position.dy) * zoom,
    );

  }

  Offset screenToWorld(Offset screen) {

    return Offset(
      screen.dx / zoom + position.dx,
      screen.dy / zoom + position.dy,
    );

  }

}