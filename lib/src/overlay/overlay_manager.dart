import 'package:flutter/material.dart';
import 'package:flutter_chaos_toolkit/src/core/models/chaos_config.dart';
import 'package:flutter_chaos_toolkit/src/overlay/chaos_overlay.dart';

class ChaosOverlayManager {
  ChaosOverlayManager._();

  static OverlayEntry? _entry;
  static final ValueNotifier<ChaosConfig> _configListenable =
      ValueNotifier<ChaosConfig>(const ChaosConfig());

  static bool get isShowing => _entry != null;

  static void show(
    BuildContext context, {
    ChaosConfig config = const ChaosConfig(),
  }) {
    if (_entry != null) {
      updateConfig(config);
      return;
    }
    final OverlayState? overlay = Overlay.maybeOf(context);
    if (overlay == null) {
      return;
    }
    _configListenable.value = config;
    _entry = OverlayEntry(
      builder: (_) {
        return ValueListenableBuilder<ChaosConfig>(
          valueListenable: _configListenable,
          builder: (_, ChaosConfig value, _) => ChaosOverlay(config: value),
        );
      },
    );
    overlay.insert(_entry!);
  }

  static void updateConfig(ChaosConfig config) {
    if (_entry == null) {
      return;
    }
    _configListenable.value = config;
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }
}
