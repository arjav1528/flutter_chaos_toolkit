import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_chaos_toolkit/src/network/network_profile.dart';

class ChaosNetworkException implements Exception {
  ChaosNetworkException(this.message);

  final String message;

  @override
  String toString() => 'ChaosNetworkException: $message';
}

class NetworkThrottler {
  final ValueNotifier<NetworkProfile> profile = ValueNotifier<NetworkProfile>(
    NetworkProfile.normal,
  );

  void setProfile(NetworkProfile next) {
    profile.value = next;
  }

  Future<void> applyDelay({
    required int estimatedBytes,
    NetworkProfile? override,
  }) async {
    final NetworkProfile active = override ?? profile.value;
    if (active == NetworkProfile.offline) {
      throw ChaosNetworkException('No internet (simulated offline profile).');
    }

    final int baseLatency = active.baseLatencyMs;
    final int throughputKbps = active.throughputKbps;
    final double bytesPerSecond = (throughputKbps * 1000) / 8;
    final int transferDelayMs = ((estimatedBytes / bytesPerSecond) * 1000)
        .ceil()
        .clamp(0, 30000);
    final int totalDelay = baseLatency + transferDelayMs;
    if (totalDelay > 0) {
      await Future<void>.delayed(Duration(milliseconds: totalDelay));
    }
  }

  void dispose() {
    profile.dispose();
  }
}
