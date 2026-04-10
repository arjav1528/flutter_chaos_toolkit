import 'package:flutter_chaos_toolkit/src/core/enums/chaos_position.dart';

class ChaosConfig {
  const ChaosConfig({
    this.position = ChaosPosition.topRight,
    this.showFPS = true,
    this.showMemory = false,
    this.showCPU = false,
    this.showFrameTime = false,
    this.showJankPercent = false,
    this.updateIntervalMs = 500,
    this.backgroundOpacity = 0.7,
    this.draggable = false,
    this.enableInRelease = false,
  });

  final ChaosPosition position;
  final bool showFPS;
  final bool showMemory;
  final bool showCPU;
  final bool showFrameTime;
  final bool showJankPercent;
  final int updateIntervalMs;
  final double backgroundOpacity;
  final bool draggable;
  final bool enableInRelease;

  ChaosConfig copyWith({
    ChaosPosition? position,
    bool? showFPS,
    bool? showMemory,
    bool? showCPU,
    bool? showFrameTime,
    bool? showJankPercent,
    int? updateIntervalMs,
    double? backgroundOpacity,
    bool? draggable,
    bool? enableInRelease,
  }) {
    return ChaosConfig(
      position: position ?? this.position,
      showFPS: showFPS ?? this.showFPS,
      showMemory: showMemory ?? this.showMemory,
      showCPU: showCPU ?? this.showCPU,
      showFrameTime: showFrameTime ?? this.showFrameTime,
      showJankPercent: showJankPercent ?? this.showJankPercent,
      updateIntervalMs: updateIntervalMs ?? this.updateIntervalMs,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
      draggable: draggable ?? this.draggable,
      enableInRelease: enableInRelease ?? this.enableInRelease,
    );
  }

  factory ChaosConfig.minimal() => const ChaosConfig(showFPS: true);

  factory ChaosConfig.performance() => const ChaosConfig(
    showFPS: true,
    showFrameTime: true,
    showJankPercent: true,
  );

  factory ChaosConfig.full() => const ChaosConfig(
    showFPS: true,
    showMemory: true,
    showCPU: true,
    showFrameTime: true,
    showJankPercent: true,
  );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is ChaosConfig &&
        other.position == position &&
        other.showFPS == showFPS &&
        other.showMemory == showMemory &&
        other.showCPU == showCPU &&
        other.showFrameTime == showFrameTime &&
        other.showJankPercent == showJankPercent &&
        other.updateIntervalMs == updateIntervalMs &&
        other.backgroundOpacity == backgroundOpacity &&
        other.draggable == draggable &&
        other.enableInRelease == enableInRelease;
  }

  @override
  int get hashCode => Object.hash(
    position,
    showFPS,
    showMemory,
    showCPU,
    showFrameTime,
    showJankPercent,
    updateIntervalMs,
    backgroundOpacity,
    draggable,
    enableInRelease,
  );
}
