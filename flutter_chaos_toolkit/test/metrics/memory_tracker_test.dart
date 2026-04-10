import 'package:flutter_chaos_toolkit/src/metrics/memory_tracker.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('updates memory usage to non-negative value', () {
    final MemoryTracker tracker = MemoryTracker();
    tracker.update();
    expect(tracker.heapUsageMB, greaterThanOrEqualTo(0));
  });
}
