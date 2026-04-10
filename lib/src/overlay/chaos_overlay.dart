import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chaos_toolkit/src/core/models/chaos_config.dart';
import 'package:flutter_chaos_toolkit/src/core/utils/position_utils.dart';
import 'package:flutter_chaos_toolkit/src/metrics/metrics_controller.dart';
import 'package:flutter_chaos_toolkit/src/overlay/widgets/metric_row.dart';
import 'package:flutter_chaos_toolkit/src/overlay/widgets/overlay_container.dart';

class ChaosOverlay extends StatefulWidget {
  const ChaosOverlay({
    super.key,
    this.config = const ChaosConfig(),
    this.onConfigChanged,
  });

  final ChaosConfig config;
  final ValueChanged<ChaosConfig>? onConfigChanged;

  @override
  State<ChaosOverlay> createState() => _ChaosOverlayState();
}

class _ChaosOverlayState extends State<ChaosOverlay> {
  late final MetricsController _controller;

  @override
  void initState() {
    super.initState();
    _controller = MetricsController();
    _controller.start(widget.config);
  }

  @override
  void didUpdateWidget(covariant ChaosOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.config != widget.config) {
      _controller.updateConfig(widget.config);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _colorForFps(double fps) {
    if (fps >= 55) return Colors.greenAccent;
    if (fps >= 45) return Colors.yellowAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode && !widget.config.enableInRelease) {
      return const SizedBox.shrink();
    }
    return IgnorePointer(
      child: Stack(
        children: <Widget>[
          ValueListenableBuilder<MetricsSnapshot>(
            valueListenable: _controller.metrics,
            builder: (BuildContext context, MetricsSnapshot snapshot, _) {
              final List<Widget> rows = <Widget>[
                if (widget.config.showFPS)
                  MetricRow(
                    label: 'FPS',
                    value: snapshot.fps.toStringAsFixed(1),
                    valueColor: _colorForFps(snapshot.fps),
                  ),
                if (widget.config.showMemory)
                  MetricRow(
                    label: 'MEM',
                    value: '${snapshot.memoryMB.toStringAsFixed(1)} MB',
                  ),
                if (widget.config.showCPU)
                  const MetricRow(label: 'CPU', value: 'N/A'),
                if (widget.config.showFrameTime)
                  MetricRow(
                    label: 'FT',
                    value: '${snapshot.frameTimeMs.toStringAsFixed(2)} ms',
                  ),
                if (widget.config.showJankPercent)
                  MetricRow(
                    label: 'Jank',
                    value: '${snapshot.jankPercent.toStringAsFixed(1)}%',
                  ),
                if (widget.config.showNetworkProfile)
                  MetricRow(
                    label: 'NET',
                    value: widget.config.networkProfile.label,
                  ),
              ];
              if (rows.isEmpty) {
                return const SizedBox.shrink();
              }
              return PositionUtils.positioned(
                position: widget.config.position,
                child: OverlayContainer(
                  opacity: widget.config.backgroundOpacity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children:
                        rows
                            .expand(
                              (Widget w) => <Widget>[
                                w,
                                const SizedBox(height: 2),
                              ],
                            )
                            .toList()
                          ..removeLast(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
