import 'package:flutter/widgets.dart';
import 'package:flutter_chaos_toolkit/src/core/enums/chaos_position.dart';

class PositionUtils {
  const PositionUtils._();

  static Positioned positioned({
    required Widget child,
    required ChaosPosition position,
    double verticalMargin = 20,
    double horizontalMargin = 10,
  }) {
    switch (position) {
      case ChaosPosition.topLeft:
        return Positioned(
          top: verticalMargin,
          left: horizontalMargin,
          child: child,
        );
      case ChaosPosition.topRight:
        return Positioned(
          top: verticalMargin,
          right: horizontalMargin,
          child: child,
        );
      case ChaosPosition.bottomLeft:
        return Positioned(
          bottom: verticalMargin,
          left: horizontalMargin,
          child: child,
        );
      case ChaosPosition.bottomRight:
        return Positioned(
          bottom: verticalMargin,
          right: horizontalMargin,
          child: child,
        );
    }
  }
}
