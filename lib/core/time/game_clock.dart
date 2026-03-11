// core/time/game_clock.dart
import 'package:flutter/scheduler.dart';

class GameClock {

  late Ticker _ticker;

  Duration _last = Duration.zero;

  void start(void Function(double dt) update) {

    _ticker = Ticker((elapsed) {

      final dt = (elapsed - _last).inMilliseconds / 1000;

      _last = elapsed;

      update(dt);

    });

    _ticker.start();
  }

  void stop() {
    _ticker.stop();
  }

}
