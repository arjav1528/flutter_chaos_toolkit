import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chaos_toolkit/src/core/enums/chaos_position.dart';
import 'package:flutter_chaos_toolkit/src/core/models/chaos_config.dart';
import 'package:flutter_chaos_toolkit/src/network/chaos_http_client.dart';
import 'package:flutter_chaos_toolkit/src/network/network_profile.dart';
import 'package:flutter_chaos_toolkit/src/network/network_throttler.dart';
import 'package:flutter_chaos_toolkit/src/overlay/overlay_manager.dart';

class ChaosToolkit {
  ChaosToolkit._();

  static ChaosToolkit? _instance;
  static ChaosToolkit get instance => _instance ??= ChaosToolkit._();
  final NetworkThrottler _networkThrottler = NetworkThrottler();
  late final ChaosHttpClient _httpClient = ChaosHttpClient(_networkThrottler);

  ChaosConfig _config = const ChaosConfig();
  final ValueNotifier<ChaosConfig> _configNotifier = ValueNotifier<ChaosConfig>(
    const ChaosConfig(),
  );

  ChaosConfig get config => _config;
  ValueListenable<ChaosConfig> get configListenable => _configNotifier;
  ChaosHttpClient get httpClient => _httpClient;

  void configure(ChaosConfig config) {
    _config = config;
    _configNotifier.value = config;
    _networkThrottler.setProfile(config.networkProfile);
    ChaosOverlayManager.updateConfig(config);
  }

  void toggleFPS() => configure(_config.copyWith(showFPS: !_config.showFPS));
  void toggleMemory() =>
      configure(_config.copyWith(showMemory: !_config.showMemory));
  void toggleCPU() => configure(_config.copyWith(showCPU: !_config.showCPU));
  void setPosition(ChaosPosition position) =>
      configure(_config.copyWith(position: position));
  void setNetworkProfile(NetworkProfile profile) =>
      configure(_config.copyWith(networkProfile: profile));

  void show(BuildContext context) {
    ChaosOverlayManager.show(context, config: _config);
  }

  void hide() {
    ChaosOverlayManager.hide();
  }

  void reset() {
    configure(const ChaosConfig());
  }

  void dispose() {
    _httpClient.close();
    _networkThrottler.dispose();
    _configNotifier.dispose();
  }
}
