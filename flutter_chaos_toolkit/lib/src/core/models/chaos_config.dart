import 'package:flutter_chaos_toolkit/src/core/enums/chaos_position.dart';
import 'package:flutter_chaos_toolkit/src/network/network_profile.dart';

class ChaosConfig {
  const ChaosConfig({
    this.position = ChaosPosition.topRight,
    this.showFPS = true,
    this.showMemory = false,
    this.showCPU = false,
    this.showFrameTime = false,
    this.showJankPercent = false,
    this.showNetworkProfile = false,
    this.updateIntervalMs = 500,
    this.backgroundOpacity = 0.7,
    this.draggable = false,
    this.enableInRelease = false,
    this.networkProfile = NetworkProfile.normal,
  });

  final ChaosPosition position;
  final bool showFPS;
  final bool showMemory;
  final bool showCPU;
  final bool showFrameTime;
  final bool showJankPercent;
  final bool showNetworkProfile;
  final int updateIntervalMs;
  final double backgroundOpacity;
  final bool draggable;
  final bool enableInRelease;
  final NetworkProfile networkProfile;

  ChaosConfig copyWith({
    ChaosPosition? position,
    bool? showFPS,
    bool? showMemory,
    bool? showCPU,
    bool? showFrameTime,
    bool? showJankPercent,
    bool? showNetworkProfile,
    int? updateIntervalMs,
    double? backgroundOpacity,
    bool? draggable,
    bool? enableInRelease,
    NetworkProfile? networkProfile,
  }) {
    return ChaosConfig(
      position: position ?? this.position,
      showFPS: showFPS ?? this.showFPS,
      showMemory: showMemory ?? this.showMemory,
      showCPU: showCPU ?? this.showCPU,
      showFrameTime: showFrameTime ?? this.showFrameTime,
      showJankPercent: showJankPercent ?? this.showJankPercent,
      showNetworkProfile: showNetworkProfile ?? this.showNetworkProfile,
      updateIntervalMs: updateIntervalMs ?? this.updateIntervalMs,
      backgroundOpacity: backgroundOpacity ?? this.backgroundOpacity,
      draggable: draggable ?? this.draggable,
      enableInRelease: enableInRelease ?? this.enableInRelease,
      networkProfile: networkProfile ?? this.networkProfile,
    );
  }

  factory ChaosConfig.minimal() => const ChaosConfig(showFPS: true);

  factory ChaosConfig.performance() => const ChaosConfig(
    showFPS: true,
    showFrameTime: true,
    showJankPercent: true,
    showNetworkProfile: true,
  );

  factory ChaosConfig.full() => const ChaosConfig(
    showFPS: true,
    showMemory: true,
    showCPU: true,
    showFrameTime: true,
    showJankPercent: true,
    showNetworkProfile: true,
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
        other.showNetworkProfile == showNetworkProfile &&
        other.updateIntervalMs == updateIntervalMs &&
        other.backgroundOpacity == backgroundOpacity &&
        other.draggable == draggable &&
        other.enableInRelease == enableInRelease &&
        other.networkProfile == networkProfile;
  }

  @override
  int get hashCode => Object.hash(
    position,
    showFPS,
    showMemory,
    showCPU,
    showFrameTime,
    showJankPercent,
    showNetworkProfile,
    updateIntervalMs,
    backgroundOpacity,
    draggable,
    enableInRelease,
    networkProfile,
  );
}
