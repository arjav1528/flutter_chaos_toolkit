import 'package:flutter_chaos_toolkit/flutter_chaos_toolkit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ChaosConfig', () {
    test('has expected defaults', () {
      const ChaosConfig config = ChaosConfig();
      expect(config.showFPS, isTrue);
      expect(config.showMemory, isFalse);
      expect(config.position, ChaosPosition.topRight);
    });

    test('copyWith overrides selected values', () {
      const ChaosConfig config = ChaosConfig();
      final ChaosConfig updated = config.copyWith(showMemory: true);
      expect(updated.showMemory, isTrue);
      expect(updated.showFPS, isTrue);
    });

    test('preset full enables all displays', () {
      final ChaosConfig full = ChaosConfig.full();
      expect(full.showFPS, isTrue);
      expect(full.showMemory, isTrue);
      expect(full.showCPU, isTrue);
      expect(full.showFrameTime, isTrue);
      expect(full.showJankPercent, isTrue);
    });
  });
}
