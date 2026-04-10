import 'package:flutter_chaos_toolkit/src/network/network_profile.dart';
import 'package:flutter_chaos_toolkit/src/network/network_throttler.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('throws in offline mode', () async {
    final NetworkThrottler throttler = NetworkThrottler();
    throttler.setProfile(NetworkProfile.offline);

    await expectLater(
      throttler.applyDelay(estimatedBytes: 1000),
      throwsA(isA<ChaosNetworkException>()),
    );
  });
}
