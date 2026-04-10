import 'dart:convert';

import 'package:flutter_chaos_toolkit/src/network/network_profile.dart';
import 'package:flutter_chaos_toolkit/src/network/network_throttler.dart';
import 'package:http/http.dart' as http;

class ChaosHttpResult {
  const ChaosHttpResult({
    required this.response,
    required this.durationMs,
    required this.profile,
  });

  final http.Response response;
  final int durationMs;
  final NetworkProfile profile;
}

class ChaosHttpClient {
  ChaosHttpClient(this._throttler, {http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;
  final NetworkThrottler _throttler;

  Future<ChaosHttpResult> get(
    Uri uri, {
    Map<String, String>? headers,
    NetworkProfile? profile,
  }) async {
    final Stopwatch sw = Stopwatch()..start();
    await _throttler.applyDelay(estimatedBytes: 1024, override: profile);
    final http.Response response = await _client.get(uri, headers: headers);
    final int responseBytes = utf8.encode(response.body).length;
    await _throttler.applyDelay(
      estimatedBytes: responseBytes,
      override: profile,
    );
    sw.stop();
    return ChaosHttpResult(
      response: response,
      durationMs: sw.elapsedMilliseconds,
      profile: profile ?? _throttler.profile.value,
    );
  }

  void close() {
    _client.close();
  }
}
