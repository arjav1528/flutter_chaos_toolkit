import 'package:flutter/material.dart';
import 'package:flutter_chaos_toolkit/flutter_chaos_toolkit.dart';
import 'package:flutter_chaos_toolkit/src/core/utils/position_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('returns positioned for topLeft', () {
    final Positioned positioned = PositionUtils.positioned(
      child: const SizedBox(),
      position: ChaosPosition.topLeft,
    );

    expect(positioned.top, 20);
    expect(positioned.left, 10);
  });
}
