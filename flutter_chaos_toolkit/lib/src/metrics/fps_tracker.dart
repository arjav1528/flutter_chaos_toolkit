import 'dart:math' as math;

import 'package:flutter/scheduler.dart';

class FpsTracker {
  final List<FrameTiming> _frames = <FrameTiming>[];
  final int maxSamples;
  bool _started = false;

  double _fps = 0;
  double _frameTimeMs = 0;
  double _jankPercent = 0;

  double get fps => _fps;
  double get frameTimeMs => _frameTimeMs;
  double get jankPercent => _jankPercent;

  void start() {
    if (_started) {
      return;
    }
    _started = true;
    SchedulerBinding.instance.addTimingsCallback(_onFrame);
  }

  void stop() {
    if (!_started) {
      return;
    }
    _started = false;
    SchedulerBinding.instance.removeTimingsCallback(_onFrame);
    _frames.clear();
  }

  FpsTracker({this.maxSamples = 60});

  void _onFrame(List<FrameTiming> timings) {
    _frames.addAll(timings);
    if (_frames.length > maxSamples) {
      _frames.removeRange(0, _frames.length - maxSamples);
    }
    _calculate();
  }

  void _calculate() {
    if (_frames.isEmpty) {
      _fps = 0;
      _frameTimeMs = 0;
      _jankPercent = 0;
      return;
    }
    final int totalMicros = _frames.fold<int>(
      0,
      (int sum, FrameTiming frame) => sum + frame.totalSpan.inMicroseconds,
    );
    final double avgMicros = totalMicros / _frames.length;
    _fps = math.max(0, 1e6 / avgMicros);
    _frameTimeMs = avgMicros / 1000;

    final int jankCount = _frames
        .where((FrameTiming frame) => frame.totalSpan.inMicroseconds > 16667)
        .length;
    _jankPercent = (_frames.isEmpty ? 0 : (jankCount / _frames.length) * 100);
  }
}
