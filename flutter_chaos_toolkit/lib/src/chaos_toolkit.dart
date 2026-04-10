import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chaos_toolkit/src/core/enums/chaos_position.dart';
import 'package:flutter_chaos_toolkit/src/core/models/chaos_config.dart';
import 'package:flutter_chaos_toolkit/src/overlay/overlay_manager.dart';

class ChaosToolkit {
  ChaosToolkit._();

  static ChaosToolkit? _instance;
  static ChaosToolkit get instance => _instance ??= ChaosToolkit._();

  ChaosConfig _config = const ChaosConfig();
  final ValueNotifier<ChaosConfig> _configNotifier = ValueNotifier<ChaosConfig>(
    const ChaosConfig(),
  );

  ChaosConfig get config => _config;
  ValueListenable<ChaosConfig> get configListenable => _configNotifier;

  void configure(ChaosConfig config) {
    _config = config;
    _configNotifier.value = config;
    ChaosOverlayManager.updateConfig(config);
  }

  void toggleFPS() => configure(_config.copyWith(showFPS: !_config.showFPS));
  void toggleMemory() =>
      configure(_config.copyWith(showMemory: !_config.showMemory));
  void toggleCPU() => configure(_config.copyWith(showCPU: !_config.showCPU));
  void setPosition(ChaosPosition position) =>
      configure(_config.copyWith(position: position));

  void show(BuildContext context) {
    ChaosOverlayManager.show(context, config: _config);
  }

  void hide() {
    ChaosOverlayManager.hide();
  }

  void reset() {
    configure(const ChaosConfig());
  }
}
