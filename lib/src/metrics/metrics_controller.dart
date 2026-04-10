import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_chaos_toolkit/src/core/models/chaos_config.dart';
import 'package:flutter_chaos_toolkit/src/metrics/fps_tracker.dart';
import 'package:flutter_chaos_toolkit/src/metrics/memory_tracker.dart';

class MetricsSnapshot {
  const MetricsSnapshot({
    this.fps = 0,
    this.frameTimeMs = 0,
    this.jankPercent = 0,
    this.memoryMB = 0,
    this.cpuPercent = 0,
  });

  final double fps;
  final double frameTimeMs;
  final double jankPercent;
  final double memoryMB;
  final double cpuPercent;
}

class MetricsController {
  final ValueNotifier<MetricsSnapshot> metrics = ValueNotifier<MetricsSnapshot>(
    const MetricsSnapshot(),
  );
  final FpsTracker _fpsTracker;
  final MemoryTracker _memoryTracker;

  Timer? _timer;
  ChaosConfig _config = const ChaosConfig();

  MetricsController({FpsTracker? fpsTracker, MemoryTracker? memoryTracker})
    : _fpsTracker = fpsTracker ?? FpsTracker(),
      _memoryTracker = memoryTracker ?? MemoryTracker();

  void start(ChaosConfig config) {
    _config = config;
    if (config.showFPS || config.showFrameTime || config.showJankPercent) {
      _fpsTracker.start();
    }
    _timer?.cancel();
    _timer = Timer.periodic(
      Duration(milliseconds: config.updateIntervalMs),
      (_) => _publish(),
    );
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    _fpsTracker.stop();
  }

  void updateConfig(ChaosConfig config) {
    stop();
    start(config);
  }

  void _publish() {
    if (_config.showMemory) {
      _memoryTracker.update();
    }
    metrics.value = MetricsSnapshot(
      fps: _fpsTracker.fps,
      frameTimeMs: _fpsTracker.frameTimeMs,
      jankPercent: _fpsTracker.jankPercent,
      memoryMB: _memoryTracker.heapUsageMB,
      cpuPercent: 0,
    );
  }

  void dispose() {
    stop();
    metrics.dispose();
  }
}
