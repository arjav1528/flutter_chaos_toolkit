import 'package:fake_async/fake_async.dart';
import 'package:flutter_chaos_toolkit/src/core/models/chaos_config.dart';
import 'package:flutter_chaos_toolkit/src/metrics/metrics_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('publishes periodic updates', () {
    fakeAsync((FakeAsync async) {
      final MetricsController controller = MetricsController();
      controller.start(const ChaosConfig(updateIntervalMs: 100));

      async.elapse(const Duration(milliseconds: 120));
      expect(controller.metrics.value, isA<MetricsSnapshot>());

      controller.dispose();
    });
  });
}
